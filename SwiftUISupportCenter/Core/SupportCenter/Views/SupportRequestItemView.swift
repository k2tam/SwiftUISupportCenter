//
//  SupportRequestItemView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI

struct SupportRequestItemView: View {
    var body: some View {
        HStack {
            VStack{
                VStack(alignment: .leading){
                    HStack(spacing: 4) {
                        Text("SGJ040120")
                            .font(.system(size: 16))
                            .fontWeight(.semibold)
                        
                        Text("Cử nhân viên")
                            .foregroundColor(Color.hiTheme.blue)
                            .font(.system(size: 12))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(
                                Color.hiTheme.secondaryBlue
                                    .cornerRadius(4)
                            )
                    }
                    
                    
                    Text("Không truy cập được Internet")
                        .font(.system(size: 16))
                        .frame(height: 24)
                }
            }
            
            Spacer()
            
            HiImage(string: "ic_right_arrow")
        }
        .frame(height: 68)
    }
}

#Preview {
    SupportRequestItemView()
}
