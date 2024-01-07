//
//  TextWithContainerView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 27/12/2023.
//

import SwiftUI

struct TextWithContainerView: View {
    let text: String
    let textColor: Color
    let containerColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(Color.hiPrimary)
            .padding(.horizontal, 8)
            .padding(.vertical, 2)
            .background(containerColor)
            .cornerRadius(4)
            
    }
}


#Preview {
    TextWithContainerView(text: "Combo Internet", textColor: Color.hiPrimary, containerColor: Color.hiBlueContainer)
}
