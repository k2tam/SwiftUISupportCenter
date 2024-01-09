////
////  HourCell.swift
////  SwiftUISupportCenter
////
////  Created by k2 tam on 21/12/2023.
////
//
//import SwiftUI
//
//
//struct HourCell: View {
//    let timeCellModel: TimeSlotModel
//    var isChecked: Bool = false
//    
//    var body: some View {
//        VStack(spacing: 4){
//            Text(timeCellModel.begin)
//                .font(.system(size: 14))
//            
//            
//            DivideLine()
//                .frame(width: 18.8, height: 1)
//                
//                
//            
//            Text(timeCellModel.end)
//                .font(.system(size: 14))
//            
//        }
//        .frame(width: 80, height: 72)
//        .background(Color.gray.opacity(0.2))
//        .modifier(ModifierColorBasedOnTimeStatus(timeStatus: timeCellModel.status))
//        .cornerRadius(8)
//
//
//        
//        
//    }
//    
//    func DivideLine() -> Color {
//        if timeCellModel.status == .allow {
//            return Color.black
//        }
//        else if timeCellModel.status == .deny {
//            return Color.hiTheme.secondaryText
//        }
//        
//        return Color.clear
//    }
//    
//   
//}
//
//struct HourScheduleLine: View {
//    @ObservedObject var vm : SupportScheduleViewModel
//    var timeSupports: [TimeSlotModel]
//    
//    var body: some View {
//
//        HStack{
//            ForEach(timeSupports) { timeSupport in
//                Button(action: {
//                    
//                }, label: {
//                    HourCell(timeCellModel: timeSupport, isChecked: checkHourCellIsChecked(timeSupport: timeSupport))
//
//                })
//            }
//        }
//        .frame(maxWidth: .infinity,  maxHeight: 72,alignment: .leading)
//        
//    }
//    
//    func checkHourCellIsChecked(timeSupport: TimeSlotModel) -> Bool{
//        guard let selectedTime = vm.selectedTime else {
//            return false
//        }
//        
//        if timeSupport == selectedTime {
//            return true
//        }
//        
//        return false
//    }
//}
//
//
//struct ModifierColorBasedOnTimeStatus : ViewModifier {
//    let timeStatus: TimeSlotStatus
//    
//    func body(content: Content) -> some View {
//        content
//            .foregroundColor(setForegroundColor())
//            .background(setBackgroundColor())
//    }
//    
//    func setBackgroundColor() -> Color {
//        if timeStatus == .allow {
//            return Color(hex: "#EFF4FF")
//        }else if timeStatus == .deny {
//            return Color(hex: "#4A6187", alpha: 0.08)
//        }
//        
//        return Color.black
//    }
//    
//    func setForegroundColor() -> Color {
//        if timeStatus == .allow {
//            return Color.black
//        }else {
//            return Color.hiTheme.secondaryText
//        }
//        
//        return Color.black
//
//    }
//}
//
////struct HourCell_Previews: PreviewProvider {
////    static var previews: some View {
////        HourCell(timeCellModel: SupportScheduleViewModel().listTime[0].supportTime[0])
////    }
////}
