//
//  HiPrimaryView.swift
//  SupportCenter
//
//  Created by k2 tam on 14/11/2023.
//

import SwiftUI

struct PrimaryButton: View {
    
    let btnText: String
    var isActive: Bool = false
    let background: String = "#4564ED"
    let backgroundActive: String = "#3C4E6D"
    let onPressed: (() -> Void)
    
    var body: some View {

        Button(action: {
            onPressed()
        }, label: {
            ZStack {
               
                RoundedRectangle(cornerRadius: 8)
                    .fill(isActive ? Color(hex: backgroundActive) :  Color(hex: background))
                Text(btnText)
                    .foregroundColor(.white)
                    .padding(.vertical, 10)
            }
        })

    }
}



