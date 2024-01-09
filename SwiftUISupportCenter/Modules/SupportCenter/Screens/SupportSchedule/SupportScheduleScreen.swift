//
//  SupportScheduleScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 19/12/2023.
//

import SwiftUI
import SwiftUIBackports

struct SupportScheduleScreen: View {
    @Backport.StateObject var vm =  SupportScheduleViewModel()
    var callBackToGetSelectedDateTimes: ( ( _ date: Date , _ time: TimeSlotModel) -> Void )?
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    
    
    init(dateTimeAllowModel: DateTimeAllowModel?, callBackToGetSelectedDateTimes: @escaping ( ( _ date: Date , _ time: TimeSlotModel) -> Void ) ){
        vm.dateTimeAllowModel = dateTimeAllowModel
        self.callBackToGetSelectedDateTimes = callBackToGetSelectedDateTimes
    }
    
    var body: some View {
        HiNavigationView {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 16){
                    HiCalendar(calendarType: .technical, checkedDate: $vm.selectedDate)
                    
                    HourSelectionView
                    
                }
                .padding(EdgeInsets(top: 16, leading: 16, bottom: 100, trailing: 16))
            }
            
            
            .hiNavigationTitle("Thời gian đặt hẹn")
            .hiNavButton("ic_x_close")
            .edgesIgnoringSafeArea(.bottom)
        }
        //        .hiFooter1Button(title: "Áp dụng", action: {
        //            guard let selectedDate =  vm.selectedDate, let selectedTime = vm.selectedTime else {return}
        //            self.callBackToGetSelectedDateTimes?(selectedDate, selectedTime)
        //            self.presentationMode.wrappedValue.dismiss()
        //        })
        
        
        
    }
}

extension SupportScheduleScreen {
    
    
    private var HourSelectionView: some View {
        
        
        VStack {
            BlockTitle(icon: "ic_clock", title: "Chọn giờ")
            
            HiDividerLine()
                .padding(.vertical, 16)
            

            VStack(spacing: 16){
                ForEach(vm.listTime){timeSlotModel in
                    HourScheduleLine(vm: self.vm, dayType: timeSlotModel.iconType, timeSupports: timeSlotModel.supportTime)
                }
            }
            
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
    }
    
    
    
    
    
    
    struct HourCell: View {
        let timeCellModel: TimeSlotModel
        var isSelected: Bool = false
        
        var body: some View {
            VStack(spacing: 4){
                Text(timeCellModel.begin)
                    .font(.system(size: 14))
                
                
                Rectangle()
                    .frame(width: 18.8, height: 1)
                
                
                
                Text(timeCellModel.end)
                    .font(.system(size: 14))
                
            }
            .frame(width: 80, height: 72)
            .modifier(ModifierColorBasedOnTimeStatus(timeStatus: timeCellModel.status, isSelected: isSelected))
            .cornerRadius(8)
            
        }
        
    }
    
    struct HourScheduleLine: View {
        @ObservedObject var vm : SupportScheduleViewModel
        var dayType: TimeSlotIconType
        var timeSupports: [TimeSlotModel]
        
        func setDayText(_ dayType: TimeSlotIconType) -> String{
            switch dayType {
            case .morning:
                return "Sáng"
            case .afternoon:
                return "Trưa"
            case .night:
                return "Chiều"
            }
        }
   
        
        var body: some View {
            VStack(alignment: .leading) {
                Text(setDayText(dayType))
                    .font(.system(size: 16))
                    .foregroundColor(Color.hiSecondaryText)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        ForEach(timeSupports) { timeSupport in
                            Button(action: {
                                self.vm.selectedTime = timeSupport
                            }, label: {
                                HourCell(timeCellModel: timeSupport, isSelected: checkHourCellIsChecked(timeSupport: timeSupport))
                                
                            })
                            .disabled(
                                checkInteractCondition(timeSupport: timeSupport)
                            )
                        }
                    }
                    .frame(maxWidth: .infinity,  maxHeight: 72,alignment: .leading)
                }
            }
            
            
            
        }
        
        func checkInteractCondition(timeSupport: TimeSlotModel) -> Bool{
            guard let selectedTime = self.vm.selectedTime else {
                return false
            }
            
            if timeSupport.status == .deny || selectedTime == timeSupport {
                return true
            }
            
            return false
        }
        
        func checkHourCellIsChecked(timeSupport: TimeSlotModel) -> Bool{
            guard let selectedTime = vm.selectedTime else {
                return false
            }
            
            if timeSupport == selectedTime {
                return true
            }
            
            return false
        }
    }
    
    
    struct ModifierColorBasedOnTimeStatus : ViewModifier {
        let timeStatus: TimeSlotStatus
        var isSelected: Bool = false
        
        func body(content: Content) -> some View {
            content
                .foregroundColor(setForegroundColor())
                .background(setBackgroundColor())
        }
        
        func setBackgroundColor() -> Color {
            if isSelected {
                return Color.hiPrimary
            }
            
            if timeStatus == .deny {
                return Color(hex: "#4A6187", alpha: 0.08)
            }
            else if timeStatus == .allow {
                return Color(hex: "#EFF4FF")
            }
            
            return Color.black
        }
        
        func setForegroundColor() -> Color {
            if isSelected {
                return Color.white
            }
            
            if timeStatus == .allow {
                return Color.black
            }else {
                return Color.hiSecondaryText
            }
            
            
        }
    }
}

struct SupportScheduleScreen_Previews: PreviewProvider {
    static var previews: some View {
        @Backport.StateObject var vm = SupportScheduleViewModel()
        
        SupportScheduleScreen(dateTimeAllowModel: vm.dateTimeAllowModel) { date, time in
            
        }
    }
}




