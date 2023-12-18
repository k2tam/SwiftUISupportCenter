//
//  HiAlert.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 17/12/2023.
//

import Foundation
import SwiftUI

struct HiAlert: View {
    let title: Text
    let message: Text?
    
    var body: some View {
        VStack(alignment: .leading){
            title
                .font(.system(size: 24, weight: .semibold))
                .frame(height: 24)
                .padding(.bottom, 24)
            
            message
                .foregroundColor(Color.gray)
                .font(.system(size: 16))
                .padding(.bottom, 24)
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
        
    }
    
    struct Button {
        var  cancel: () -> Void
    }
    
}

struct hiAlertModifier : ViewModifier {
    @Binding var isPresented: Bool
    @ViewBuilder let hiAlertContent: () -> HiAlert
    
    func body(content: Content) -> some View {
        ZStack{
            content
            if isPresented {
                Color.gray.opacity(0.5)
                    .animation(.easeInOut(duration: 2))
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture(perform: {
                        
                        isPresented.toggle()
                    })
                
                hiAlertContent()
                    .transition(isPresented ? .opacity.animation(.easeIn(duration: 0.25)) : .opacity)

            }
        }
        
    }
}

extension View {
    func hiAlert(isPresented: Binding<Bool>,content: @escaping () -> HiAlert) -> some View {
        self
            .modifier(hiAlertModifier(isPresented: isPresented, hiAlertContent: content))
    }
}

//Previews
struct HiAlertPreview: View {
    @State var isPresented: Bool = false
    var body: some View {
        VStack{
            Button(action : {
                isPresented.toggle()
            }, label: {
                Text("Show Hi Alert")
            })
            
        }
        .hiAlert(isPresented: $isPresented) {
            HiAlert(
                title: Text("Thông báo"),
                message: Text("This is Hi Alert of Hi FPT customized from Swift UI Alert")
            )
        }

    }
}


struct HiAlert_Previews: PreviewProvider {
    static var previews: some View {
        HiAlertPreview()
    }
}

