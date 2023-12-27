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
            ZStack(alignment: .bottom){
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading){
                        
                        Text("Chọn ngày")
                            .font(.system(size: 18, weight: .medium))
                            .padding(.leading, 16)
                            .frame(maxHeight: 36)
                            .padding(.bottom, 8)
                        
                        HiCalendar(calendarType: .technical, checkedDate: $vm.selectedDate)
                            .frame(height: 350) // Adjust the value as needed
                        
                        
                        HourSelectionView
                        
                    }
                    .padding(.bottom, 100)
                }
                
                ApplyButton
                
            }
            .hiNavigationTitle("Thời gian đặt hẹn")
            .edgesIgnoringSafeArea(.bottom)
            
            
        }
        
        
    }
}

extension SupportScheduleScreen {
    
    
    private var HourSelectionView: some View {
        
        
        Group {
            Text("Chọn giờ")
                .font(.system(size: 18, weight: .medium))
                .frame(maxWidth: .infinity, maxHeight: 36,alignment: .leading)
                .padding(.leading, 60)
                .padding(.bottom, 8)
            
            VStack(spacing: 16){
                HStack{
                    VStack{
                        HeaderHourSchedule(inDayTime: .morning)
                        HeaderHourSchedule(inDayTime: .afternoon)
                        HeaderHourSchedule(inDayTime: .night)
                    }
                    .frame(maxWidth: 37)
                    .padding(.trailing, 20)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        VStack(spacing: 16){
                            ForEach(vm.listTime){timeSlotModel in
                                HourScheduleLine(vm: self.vm, timeSupports: timeSlotModel.supportTime)
                                
                            }
                        }
                    }
                    
                    
                    
                }
            }
            .frame(height: 248)
            .padding(.leading, 16)
        }
    }
    
    //MARK: - Apply Button
    private var ApplyButton: some View {
        ZStack{
            Color.white
            
            PrimaryButton(btnText: "Áp dụng") {
                guard let selectedDate =  vm.selectedDate, let selectedTime = vm.selectedTime else {return}
                self.callBackToGetSelectedDateTimes?(selectedDate, selectedTime)
                self.presentationMode.wrappedValue.dismiss()
                
            }
            .padding(.init(top: 16, leading: 16, bottom: 16, trailing: 16))
            .frame(maxWidth: .infinity)
            
            
        }
        .frame(maxHeight: 80)
    }
    
    
    struct HeaderHourSchedule: View {
        let inDayTime: TimeSlotIconType
        
        var body: some View {
            VStack(spacing: 4){
                HiImage(string: inDayTime.iconString())
                
                Text(inDayTime.text())
                    .font(.system(size: 14))
            }
            .frame(width: 40,height: 72)
        }
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
        var timeSupports: [TimeSlotModel]
        
        var body: some View {
            
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

//struct SupportScheduleScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        @Backport.StateObject var vm = SupportScheduleViewModel()
//
//        SupportScheduleScreen(dateTimeAllowModel: vm.dateTimeAllowModel) { date, time in
//
//        }
//    }
//}




