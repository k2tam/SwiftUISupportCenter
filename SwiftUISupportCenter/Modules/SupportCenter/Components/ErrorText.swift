//
//  ErrorText.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 09/01/2024.
//

import SwiftUI

struct ErrorText: View {
    let text: String
    var body: some View{
        Text("Vui lòng nhập \(text.lowercased())")
            .font(Font.system(size: 14))
            .foregroundColor(.red)
    }
}
