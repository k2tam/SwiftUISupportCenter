//
//  RequestStatusView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 15/12/2023.
//

import SwiftUI

struct RequestStatusView: View {
    var body: some View {
        VStack{
            Button(action: {
//                callBackNavToRequestStatusTimeLineScreen()
            }, label: {
                VStack{
                    BlockTitle(icon: "ic_calendar_with_clock", title: "Trạng thái yêu cầu", isShowArrow: true)
                        .padding(.bottom, 8)
                    
                    RequestProcessWithVLineView(time: "18/02/2022\n08:15", statusTitle: "Nhân viên đã xử lý xong", statusDetail: "")
                        .padding(.top, 8)
                    
                    HiDividerLine()
                        .padding(.vertical, 8)
                    
                    HStack(alignment: .top){
                        Color.blue
                            .frame(width: 48, height: 48)
                            .padding(.trailing, 16)
                        
                        VStack(alignment: .leading, spacing: 2){
                            Text("TRƯƠNG HUỲNH TUẤN KHANG")
                                .font(.system(size: 14, weight: .medium))
                            
                            
                            Text("Kỹ thuật viên")
                                .font(.system(size: 14))
                        }
                        
                        Spacer()
                        
                        
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    HiDividerLine()
                        .padding(.vertical, 8)
                }
            })
            .foregroundColor(.black)
            
           
           
            
            HStack{
                Text("Thiết bị vật tư")
                    .font(.system(size: 14))
                    .frame(maxWidth: .infinity, maxHeight: 24,alignment: .leading)
                
                Spacer()
                
                HiImage(string: "ic_arrow_down")
            }
            
  
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 16)
        .background(Color.white)
    }
}

//#Preview {
//    RequestStatusView(callBackNavToRequestStatusTimeLineScreen: <#() -> Void#>)
//}
