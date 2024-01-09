//
//  BaseView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 08/01/2024.
//

import SwiftUI

struct HiBaseScreen<Content: View>: View {
    private let content: Content
    
    
    public init(@ViewBuilder content: () -> Content){
        self.content = content()
    }
    
    var body: some View {
        ZStack{
            Color.hiBackground
            content
        }
        .edgesIgnoringSafeArea(.bottom)
        
    }
}

enum eDirection {
    case vertical
    case horizontal
}

extension HiBaseScreen {
    
    /// Show footer with 1 button, buttonType default is primary if not pass value
    /// - Parameters:
    ///   - buttonType: if not pass any value, DEFAULT WILL BE PRIMARY
    ///   - title: title
    ///   - action: action
    /// - Returns: View
    func hiFooter1Button(buttonType: eButtonType = .primary, title: String, action: @escaping () -> Void) -> some View {
        self.modifier(footer1Button(buttonType: buttonType, title: title, action: action))
    }
    
    func hiFooter2Button(direction: eDirection,primaryTitle: String, primaryAction: @escaping () -> Void, secondaryTitle: String, secondaryAction:  @escaping () -> Void) -> some View {
        self
            .modifier(footer2Buttons(direction: direction, primaryTitle: primaryTitle, primaryAction: primaryAction, secondaryTitle: secondaryTitle, secondaryAction: secondaryAction))
        
    }
}

struct footer1Button: ViewModifier {
    let buttonType: eButtonType
    let title: String
    let action: (() -> Void)

    func body(content: Content) -> some View {
        
        ZStack(alignment: .bottom){
            content
            
            ZStack{
                Color.white
                
                
                HiButton(type: buttonType, btnText: title) {
                    action()
                }
                .padding(.init(top: 16, leading: 16, bottom: 32, trailing: 16))
                .frame(maxWidth: .infinity)
            }
            .frame(maxHeight: 96)
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
}

struct footer2Buttons: ViewModifier {
    let direction: eDirection
    let primaryTitle: String
    let primaryAction: () -> Void
    let secondaryTitle: String
    let secondaryAction: () -> Void
    
    func body(content: Content) -> some View {
        ZStack(alignment: .bottom){
            content
            
            ZStack{
                Color.white
                
                if direction == .horizontal {
                    HStack{
                        HiButton(type: .secondary, btnText: secondaryTitle) {
                            secondaryAction()
                        }
                        HiButton(type: .primary, btnText: primaryTitle) {
                            primaryAction()
                        }
                    }
                    .padding(.init(top: 16, leading: 16, bottom: 32, trailing: 16))
                    .frame(maxHeight: 96)

                }else {
                    VStack{
                        HiButton(type: .primary, btnText: primaryTitle) {
                            primaryAction()
                        }
                        HiButton(type: .secondary, btnText: secondaryTitle) {
                            secondaryAction()
                        }
                    }
                    .padding(.init(top: 16, leading: 16, bottom: 32, trailing: 16))
                    .frame(maxHeight: 122)
                }
            }
            .edgesIgnoringSafeArea(.bottom)

            
        }
    }
}

#Preview {
    HiBaseScreen {
        Text("Hello")
    }
}
