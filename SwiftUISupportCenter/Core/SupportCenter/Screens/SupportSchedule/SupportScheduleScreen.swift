//
//  SupportScheduleScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 19/12/2023.
//

import SwiftUI

enum eInDayTime{
    case morning
    case afternoon
    case night
    
    func iconString() -> String {
        switch self {
        case .morning:
            return "ic_sun_rise"
        case .afternoon:
            return "ic_sun_set"
        case .night:
            return "ic_moon"
        }
    }
    
    func text() -> String {
        switch self {
        case .morning:
            return "Sáng"
        case .afternoon:
            return "Chiều"
        case .night:
            return "Tối"
        }
    }
}



struct SupportScheduleScreen: View {
    var body: some View {
        HiNavigationView {
            ZStack(alignment: .bottom){
                ScrollView {
                    VStack(alignment: .leading){
                        
                        Text("Chọn ngày")
                            .font(.system(size: 18, weight: .medium))
                            .padding(.leading, 16)
                            .frame(maxHeight: 36)
                            .padding(.bottom, 8)
                        
                        HiCalendar()
                        
                        
                        Text("Chọn giờ")
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity, maxHeight: 36,alignment: .leading)
                            .padding(.leading, 60)
                            .padding(.bottom, 8)
                        
                        VStack(spacing: 16){
                            HourScheduleLine(inDayTime: .morning)
                            HourScheduleLine(inDayTime: .afternoon)
                            HourScheduleLine(inDayTime: .night)
                            
                        }
                        .padding(.leading, 16)
                        
                    }
                }
                
                CreateButton
                
            }
            .hiNavigationTitle("Thời gian đặt hẹn")
            .edgesIgnoringSafeArea(.bottom)
            
            
        }
        
        
    }
}

extension SupportScheduleScreen {
    
    private var CreateButton: some View {
        ZStack{
            Color.white
            
            PrimaryButton(btnText: "Áp dụng") {
                
            }
            .padding(.init(top: 16, leading: 16, bottom: 32, trailing: 16))
            .frame(maxWidth: .infinity)
            
            
        }
        .frame(maxHeight: 96)
    }
    
    
    struct HeaderHourSchedule: View {
        let inDayTime: eInDayTime
        
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
        var isAvailable: Bool
        var isSelected: Bool = false
        
        var body: some View {
            VStack{
                Text("08:00")
                    .font(.system(size: 14))
                
                Color(hex: "#969696")
                    .frame(width: 18, height: 1)
                
                
                Text("09:00")
                    .font(.system(size: 14))
                
            }
            .frame(maxWidth: 80, maxHeight: .infinity)
            .padding()
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            
            
        }
    }
    
    struct HourScheduleLine: View {
        let inDayTime: eInDayTime
        
        var body: some View {
            HStack{
                HeaderHourSchedule(inDayTime: inDayTime)
                    .padding(.trailing, 24)
                
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                        HourCell(isAvailable: true)
                    }
                }
            }
            .frame(maxWidth: .infinity,  maxHeight: 72,alignment: .leading)
            
        }
    }
}

#Preview {
    SupportScheduleScreen()
}
