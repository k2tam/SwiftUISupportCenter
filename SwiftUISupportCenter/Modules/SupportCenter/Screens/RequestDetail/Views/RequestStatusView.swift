//
//  RequestStatusView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 15/12/2023.
//

import SwiftUI

struct RequestStatusView: View {
    var callBackNavToRequestStatusTimeLineScreen: () -> Void
    var body: some View {
        VStack{
            Button(action: {
                callBackNavToRequestStatusTimeLineScreen()
            }, label: {
                VStack{
                    BlockTitle(icon: "ic_state", title: "Trạng thái yêu cầu", isShowArrow: true)
                        .padding(.bottom, 8)
                    
                    RequestProcessWithVLineView(time: "18/02/2022\n08:15", statusTitle: "Nhân viên đã xử lý xong", statusDetail: "")
                        .padding(.top, 8)
                    
                    
                }
            })
            .foregroundColor(.black)
    
  
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct RequestStatusView_Previews: PreviewProvider {
    
    static var previews: some View {
        RequestStatusView {
            print("Hello")
        }
        .previewLayout(.sizeThatFits)
    }
}
