//
//  UITextView.swift
//  SupportCenter
//
//  Created by k2 tam on 15/11/2023.
//

import SwiftUI

struct CustomTextView: UIViewRepresentable {
    typealias UIViewType = UITextView
    
    @Binding var text: String
    
    var configuration = { (view: UIViewType) in }
    
    func makeUIView(context: UIViewRepresentableContext<Self>) -> UIViewType {
        UIViewType()
    }
    
    func updateUIView(_ uiView: UIViewType, context: UIViewRepresentableContext<Self>) {
        configuration(uiView)
        uiView.text = text
    }
}

//#Preview {
//    UITextView()
//}
