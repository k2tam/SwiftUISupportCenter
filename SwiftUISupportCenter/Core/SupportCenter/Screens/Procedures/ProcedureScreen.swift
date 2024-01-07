//
//  ProcedureScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 03/01/2024.
//

import SwiftUI

struct ProcedureScreen: View {
    var body: some View {
        ZStack {
            HiNavigationView {
                ZStack(alignment: .bottom){
                    
                    Color.hiBackground
                    
                    
                    
                    createButton
                    
                }
                .hiNavigationTitle("Tạo yêu cầu")

    
            }
            
            
            GeometryReader { geometry in
//                HiBottomSheet(isCardShow: $isCardShow, height: geometry.size.height * 0.6, minHeight: geometry.size.height * 0.3) {
//                    SupportRequestBottomSheetContent(isShow: $isCardShow)
//                    
//                    
//                }
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

extension ProcedureScreen {
    private var createButton: some View {
        ZStack{
            Color.white
            
            PrimaryButton(btnText: "Tiếp tục") {
                
            }
            .padding(.init(top: 16, leading: 16, bottom: 32, trailing: 16))
            .frame(maxWidth: .infinity)
            
            
        }
        .frame(maxHeight: 96)
    }
}

#Preview {
    ProcedureScreen()
}
