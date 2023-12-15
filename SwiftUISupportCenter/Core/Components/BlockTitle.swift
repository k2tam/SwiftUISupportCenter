//
//  BlockTitle.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 15/12/2023.
//

import SwiftUI

struct BlockTitle: View {
    let icon: String
    let title: String
    var isShowArrow: Bool = false
    
    var body: some View {
        HStack{
            HiImage(string: icon)
                .frame(width: 24, height: 24)
            
            Text(title)
                .font(Font.system(size: 16))
                .fontWeight(.medium)
                .padding(.leading, 8)
            
            Spacer()
            
            if isShowArrow {
                HiImage(string: "ic_right_arrow")
                    .frame(width: 24, height: 24)
            }
            
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    BlockTitle(icon: "ic_note", title: "Ghi chú", isShowArrow: true)
}
