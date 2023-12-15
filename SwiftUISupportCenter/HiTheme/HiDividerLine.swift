//
//  DividerView.swift
//  SupportCenter
//
//  Created by k2 tam on 06/11/2023.
//

import SwiftUI

struct HiDividerLine: View {
    let hexColor: String
    
    init(hexColor: String = "#CAD3E2"){
        self.hexColor = hexColor
    }
    
    var body: some View {
        Color(hex: hexColor)
            .frame(maxWidth: .infinity,maxHeight: 1)
    }
}

//#Preview {
//    DividerView()
//}
