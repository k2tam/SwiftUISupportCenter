//
//  HiNavigationView.swift
//  SupportCenter
//
//  Created by k2 tam on 07/12/2023.
//

import SwiftUI

struct HiNavigationView<Content: View>: View {
    let content: Content
    @State private var showNavButton: Bool = true
    @State private var navButton: String = "ic_nav_left_arrow"
    @State private var title: String = ""
    @State private var toolBar: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()))
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.hiBackground
            
            NavViewHeaderAndContent
            
            
        }
        .edgesIgnoringSafeArea(.bottom)
    }
    
    
    
    private var NavViewHeaderAndContent: some View {
        VStack(spacing: 0){
            HiNavigationBarView(showNavButton: showNavButton, navButton: navButton, title: title, toolBar: toolBar)
            
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .onPreferenceChange(HiNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(HiNavBarButtonHiddenPreferenceKey.self, perform: { value in
            self.showNavButton = !value
        })
        .onPreferenceChange(HiNavBarToolBarPreferenceKey.self, perform: { value in
            self.toolBar = value
        })
        .onPreferenceChange(HiNavBarBtnPreferenceKey.self, perform: { value in
            self.navButton = value
        })
    }
}



#Preview {
    HiNavigationView {
        ZStack{
            Color.purple.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            
            Text("Hi FPT")
                .foregroundColor(.white)
        }
    }
}


struct HiNavigationBarView: View {
    @Environment(\.presentationMode) var presentationMode
    let showNavButton: Bool
    let navButton: String
    let title: String
    let toolBar: EquatableViewContainer
    
    var body: some View {
        ZStack{
                        
            Text(title)
                .font(.system(size: 18, weight: .medium))
        
            
            HStack{
                if showNavButton {
                    backButton
                }
                
                Spacer()

                toolBar.view
            }
        }
        
        .padding(.horizontal, 16)
        .frame(height: 56)
        .background(Color.white)

      
    }
}

extension HiNavigationView {
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


extension HiNavigationBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            HiImage(string: self.navButton)
                .foregroundColor(Color(hex: "#333333"))
        })
    }
    
    
}



