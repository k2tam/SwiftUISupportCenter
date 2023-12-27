//
//  HiLoadingScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 26/12/2023.
//

import SwiftUI
import Lottie


struct HiLoadingScreen: View {

    var body: some View {
        ZStack{
          
            LottieView(animation: .named("fpt_loading"))
                .looping()
                .frame(width: 80, height: 80)
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        
    }
}

#Preview {
    HiLoadingScreen()
}
