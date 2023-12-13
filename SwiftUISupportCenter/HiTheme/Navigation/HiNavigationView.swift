//
//  HiNavigationView.swift
//  SupportCenter
//
//  Created by k2 tam on 07/12/2023.
//

import SwiftUI

struct HiNavigationView<Content: View>: View {
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var toolBar: EquatableViewContainer = EquatableViewContainer(view: AnyView(EmptyView()))
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0){
            HiNavigationBarView(showBackButton: showBackButton, title: title, toolBar: toolBar)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarHidden(true)
        .onPreferenceChange(HiNavBarTitlePreferenceKey.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(HiNavBarBackButtonHiddenPreferenceKey.self, perform: { value in
            self.showBackButton = !value
        })
        .onPreferenceChange(HiNavBarToolBarPreferenceKey.self, perform: { value in
            self.toolBar = value
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
    let showBackButton: Bool
    let title: String
    let toolBar: EquatableViewContainer
    
    var body: some View {
        HStack{
            if showBackButton {
                backButton
            }
            
            Spacer()
            
            Text(title)
                .font(.system(size: 18, weight: .medium))
            
            Spacer()
            
            toolBar.view
        }
        .padding(.horizontal, 16)
        .frame(height: 56)
      
    }
}

extension HiNavigationBarView {
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Image(systemName: "chevron.left")
                .foregroundColor(Color(hex: "#333333"))
        })
    }
}



