//
//  HiLoading.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 27/12/2023.
//

import Foundation
import SwiftUI
import Lottie


struct HiLoading: ViewModifier {
    var showLoading: Bool
    
        func body(content: Content) -> some View {
            ZStack {
                content
                    .allowsHitTesting(showLoading ? false : true)

                if showLoading {
                    LottieView(animation: .named("fpt_loading"))
                        .looping()
                        .frame(width: 80, height: 80)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
        }
}


extension View {
    func hiLoading(showLoading: Bool) -> some View {
        self
            .modifier(HiLoading(showLoading: showLoading))
    }
}

