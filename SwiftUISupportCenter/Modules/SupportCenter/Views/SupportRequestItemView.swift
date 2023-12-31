//
//  SupportRequestItemView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI

struct SupportRequestItemView: View {
    let supportRequest: SupportRequest
    
    var body: some View {
        HStack {
            VStack(spacing: 0){
                VStack(alignment: .leading){
                    HStack(spacing: 4) {
                        Text(supportRequest.contractNo)
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Text(supportRequest.lastStepName)
                            .foregroundColor(Color.hiPrimary)
                            .font(.system(size: 12))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(
                                Color.hiBlueContainer
                                    .cornerRadius(4)
                            )
                    }
                    
                    
                    Text(supportRequest.subTypeName)
                        .font(.system(size: 16))
                        .frame(height: 24)
                }
            }
            
            Spacer()
            
            HiImage(string: "ic_right_arrow")
        }
        .padding(.vertical, 8)
        .frame(height: 64)

    }
}

struct SupportRequestItemView_Previews: PreviewProvider {
    static var previews: some View {
        if let supportRequest = dev.supportRequestList?.report[0] {
            SupportRequestItemView(supportRequest: supportRequest)
                .previewLayout(.sizeThatFits)
        }
        
    }
}

