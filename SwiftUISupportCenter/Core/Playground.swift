//
//  Playground.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import SwiftUI

struct Playground: View {
    @State  var isShow: Bool = false
    var body: some View {
        ZStack {
            Button(action: {
                isShow.toggle()
            }, label: {
                Text("Toggle")
            })
            
            HiSupportBottomSheet(isShow: $isShow, heightOfEachItem: 56)
        }
    }
}

#Preview {
    Playground(isShow: false)
}
