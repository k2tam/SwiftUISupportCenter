//
//  SupportRequestListView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI

struct SupportRequestListView: View {
    let supportRequestList: [SupportRequest]
        
    var body: some View {
        VStack(spacing: 16){
            BlockNavHeader(title: "Danh sách yêu cầu") {
            }
            
            //Report List
            VStack(spacing: 0){
                ForEach(Array(supportRequestList.enumerated()), id: \.offset){index, item in
                    
                    
                    NavigationLink {
                        RequestDetailScreen(supportRequest: supportRequestList[0])
                    } label: {
                        SupportRequestItemView(supportRequest: item)
                            .foregroundColor(.black)
                    }

                   
                    
                    //List divider line
                    if index != supportRequestList.count - 1 {
                        
                        HiDividerLine()
                            .frame(maxWidth: .infinity, maxHeight: 1)
                            .padding(.vertical, 8)
                    }
                   
                }

            }
            .padding(.all ,16)
            .background(Color.white.cornerRadius(8))
            
        }
        .padding(.horizontal, 16)
    }
}



struct SupportRequestListView_Previews: PreviewProvider {
    static var previews: some View {
        SupportRequestListView(supportRequestList: dev.supportRequestList?.report ?? [] )
            .previewLayout(.sizeThatFits)
    }
}
