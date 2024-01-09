//
//  RequestProcessWithVLineView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 15/12/2023.
//

import SwiftUI

struct RequestProcessWithVLineView: View {
    var isLastProcess: Bool = false
    var paddingBottom: CGFloat
    let time: String
    let statusTitle: String
    let statusDetail: String
    
    @State var processLineHeight: CGFloat = 0
    
    init(isLastProcess: Bool = false , paddingBottom: CGFloat = 0,time: String, statusTitle: String, statusDetail: String) {
        self.isLastProcess = isLastProcess
        self.paddingBottom = paddingBottom
        self.time = time
        self.statusTitle = statusTitle
        self.statusDetail = statusDetail
    }
    
    var body: some View {
        HStack(alignment: .top){
            Text("18/02/2022\n08:15")
                .font(.system(size: 12))
                .multilineTextAlignment(.trailing)
                .lineSpacing(3)
            
            
            ZStack(alignment: .top){
                if !isLastProcess {
                    Color(hex: "#D1D1D1")
                        .frame(width: 1, height:  processLineHeight + paddingBottom)
                }
               
                
                HiImage(string: "ic_done")
                    .padding(.horizontal, 17)
                    .background(Color.white)
                
                
            }
            
            VStack(alignment: .leading, spacing: 6){
                Text(statusTitle)
                    .font(.system(size: 14))
                
                if statusDetail != "" {
                    Text(statusDetail)
                        .font(.system(size: 14))
                }
              
                
            }
        }
        .background(GeometryReader { geo in
            Color.clear
                .onAppear(perform: {
                    processLineHeight = geo.size.height
                })
        })
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

#Preview {
    RequestProcessWithVLineView(paddingBottom: 0, time: "", statusTitle: "Nhân viên đã xử lý xong", statusDetail: "Lý do: Khách hàng huỷ HĐ")
}
