//
//  ErrorTextView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 08/01/2024.
//

import SwiftUI

struct ErrorTextView: View {
    let errorText: String
    var body: some View {
        Text("Vui lòng nhập \(errorText)")
            .font(Font.system(size: 14))
            .foregroundColor(.red)
    }
    
    
}

#Preview {
    ErrorTextView(errorText: "ghi chú")
}
