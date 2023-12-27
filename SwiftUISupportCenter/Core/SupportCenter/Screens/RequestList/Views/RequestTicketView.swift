//
//  RequestList.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 26/12/2023.
//

import SwiftUI

enum eRequestTicketItem {
    case contractItem
    case problem
    case schedule
    case state
    case employee
}

struct RequestTicketView: View {
    var ticketItems: [eRequestTicketItem] = [.contractItem, .problem, .schedule, .state, .employee]
    
    var body: some View {
        VStack(spacing: 0){
            ForEach(Array(ticketItems.enumerated()), id: \.element){ index, item in
                VStack {
                    switch item {
                    case .contractItem:
                        ContractRow()
                    case .problem:
                        ProblemRow()
                    case .schedule:
                        ScheduleRow()
                    case .state:
                        StateRow()
                    case .employee:
                        EmployeeRow()
                    }
                    
                    if index != ticketItems.count - 1{
                        HiDividerLine()
                            .padding(.vertical, 16)
                    }
                }
               
            }
            
          
            
        }
        .frame(maxWidth: .infinity)
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
        
    }
}

#Preview {
    RequestTicketView()
}

struct ContractRow: View {
    var body: some View {
        HStack{
            Image(systemName: "apple.logo")
                .resizable()
                .scaledToFit()
                .frame(width: 36, height: 36)
                .padding(.trailing, 12)
            
            Text("LPKJB8376")
                .font(.system(size: 18,weight: .medium))
            
            Spacer()
            
            Text("29/10/2023")
                .font(.system(size: 16))
                .foregroundColor(Color.hiTheme.secondaryText)
        }
    }
}

struct ProblemRow: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 2){
                Text("Tình trạng")
                    .font(.system(size: 16))
                    .foregroundColor(Color.hiTheme.secondaryText)
                
                Text("Mạng chập chờn")
                    .font(.system(size: 16,weight: .medium))
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct ScheduleRow: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 2){
                Text("Đặt hẹn")
                    .font(.system(size: 16))
                    .foregroundColor(Color.hiTheme.secondaryText)
                
                Text("29/11/2023, 09:00 - 10:00")
                    .font(.system(size: 16,weight: .medium))
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct StateRow: View {
    var body: some View {
        HStack{
            VStack(alignment: .leading, spacing: 8){
                Text("Trạng thái")
                    .font(.system(size: 16))
                    .foregroundColor(Color.hiTheme.secondaryText)
                
                Text("Đang phân công nhân viên xử lý")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .foregroundColor(Color.hiTheme.primaryColor)
                    .background(Color.hiTheme.secondaryBlue)
                    .cornerRadius(4)
                
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}

struct EmployeeRow: View {
    var body: some View {
        VStack {
            //Employee block
            HStack{
                VStack(alignment: .leading, spacing: 8){
                    Text("Nhân viên")
                        .font(.system(size: 16))
                        .foregroundColor(Color.hiTheme.secondaryText)
                    
                    HStack{
                        Image(systemName: "apple.logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 40)
                            .padding(.trailing, 8)
                        
                        VStack(alignment: .leading){
                            Text("Trương Huỳnh Tuấn Khang")
                                .lineLimit(1)
                                .font(.system(size: 16, weight: .medium))
                            Text("0912345678")
                                .font(.system(size: 16))
                                .foregroundColor(Color.hiTheme.secondaryText)
                        }
                        
                        Spacer()
                        
                        HStack {
                            Button(action: {
                                
                            }, label: {
                                HiImage(string: "ic_location")
                                    .frame(width: 24, height: 24)
                            })
                            
                            Button(action: {
                                
                            }, label: {
                                HiImage(string: "ic_phone")
                                    .frame(width: 24, height: 24)
                            })
                        }
                        
                    }
                    
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            
            HiDividerLine()
                .padding(.vertical, 16)
            
            //Cancel request butotn
            Button(action: {
                
            }, label: {
                HStack{
                    HiImage(string: "ic_red_trash")
                    
                    Text("Huỷ yêu cầu")
                        .foregroundColor(Color(hex: "#FF2156"))
                    
                }
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(hex: "#FFF3F6"))
                .cornerRadius(8)
                
            })
            
        }
    }
}
