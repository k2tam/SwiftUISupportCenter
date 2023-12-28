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
        HStack(spacing: 16){
            HiImage(string: icon)
                .frame(width: 36, height: 36)
            
            Text(title)
                .font(Font.system(size: 18))
                .fontWeight(.medium)
     
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .frame(height: 36)
    }
}

#Preview {
    BlockTitle(icon: "ic_note", title: "Ghi chú", isShowArrow: true)
}
