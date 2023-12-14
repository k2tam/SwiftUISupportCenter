//
//  BlockTitle.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI

/// Block Title
/// ```
/// title: Title for block
/// action: call back action if nil then block title will not have arrow button
/// ```
struct BlockTitle: View {
    let title: String
    let action: (() -> Void)?
    
    
    init(title: String, action: ( () -> Void)? = nil) {
        self.title = title
        self.action = action
    }
    
    var body: some View {
        
        HStack(spacing: 8){
            Text(title)
                .font(.system(size: 20))
                .fontWeight(.medium)
            
            if action != nil {
                HiImage(string: "ic_right_arrow")
                    .background(
                        Circle()
                            .fill(Color.white)
                    )
                    .frame(width: 12, height: 12)
                
                    .padding(.leading, 8)
            }
            
            Spacer()
        }
        .onTapGesture(perform: {
            action?()
        })
    }
}

#Preview {
    BlockTitle(title: "Danh sách yêu cầu") {
        
    }
}
