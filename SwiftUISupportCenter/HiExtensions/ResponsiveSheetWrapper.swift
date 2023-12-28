//
//  ResponsiveSheetWrapper.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 28/12/2023.
//

import Foundation

//
//  ResponsiveSheetWrapper.swift
//
//  Created by Bacem Ben Afia on 04/08/2022.
//  ba.bessem@gmail.com

import SwiftUI
import UIKit

//MARK: - ViewModifier
fileprivate struct ResponsiveSheetWrapper: ViewModifier {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    func body(content: Content) -> some View {
        /// check device type (ipad sheet are centred / iPhone sheet pinned to bottom )
        if UIDevice.current.userInterfaceIdiom == .phone {
            ZStack (alignment: .bottom){
                Color(UIColor.systemBackground.withAlphaComponent(0.01))
                    .onTapGesture {
                        // tap outside the view to dismiss
                        presentationMode.wrappedValue.dismiss()
                    }
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    /// the small thumb for bottom sheet native like
                    thumb
                    content
                }
                /// redesign the content
                .asResponsiveSheetContent()
            }
            /// remove system background
            .clearSheetSystemBackground()
            .edgesIgnoringSafeArea(.bottom)
        } else {
            ZStack {
                Color(UIColor.systemBackground.withAlphaComponent(0.01))
                    .onTapGesture {
                        // tap outside the view to dismiss
                        presentationMode.wrappedValue.dismiss()
                    }
                content
                /// redesign the content
                .asResponsiveSheetContent()
            }
            /// remove system background
            .clearSheetSystemBackground()
            .edgesIgnoringSafeArea(.all)
        }
    }
    
    var thumb: some View {
        HStack{
            Spacer()
            Capsule()
                .frame(width: 40, height: 4)
                .foregroundColor(Color(UIColor.systemFill))
            Spacer()
        }
        .padding(.top, 8)
        .padding(.bottom, 8)
    }
}

fileprivate struct ResponsiveSheetContent: ViewModifier {
    /// ResponsiveSheetContent will create the form of a bottom sheet (apply corners radius for both iPad an iPhone sheet)
    @Environment(\.safeAreaInsets) private var safeAreaInsets
    
    func body(content: Content) -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            content
                .padding(.bottom, safeAreaInsets.bottom)
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10, corners: [.topLeft, .topRight])
        } else {
            content
                .padding()
                .background(Color(UIColor.systemBackground))
                .cornerRadius(10, corners: [.allCorners])
        }
    }
}

fileprivate struct ClearBackgroundViewModifier: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .background(ClearBackgroundView())
    }
}

fileprivate struct CornerRadiusStyle: ViewModifier {
    var radius: CGFloat
    var corners: UIRectCorner
    
    struct CornerRadiusShape: Shape {

        var radius = CGFloat.infinity
        var corners = UIRectCorner.allCorners
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            return Path(path.cgPath)
        }
    }

    func body(content: Content) -> some View {
        content
            .clipShape(CornerRadiusShape(radius: radius, corners: corners))
    }
}

//MARK: - UIViewRepresentable
fileprivate struct ClearBackgroundView: UIViewRepresentable {
    /// The Key
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            /// GOD BLESS UI KIT
            /// Target sheet system background view
            /// Apply clear Color
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

//MARK: - View Extension
extension View {
    /// Return a formatted View Based on Device Type
    /// if iPad => Centred Alert-Like View
    /// if iPhone => Bottom Sheet View
    /// That's all folks
    func asResponsiveSheet() -> some View {
        self.modifier(ResponsiveSheetWrapper())
    }
    
    fileprivate func asResponsiveSheetContent() -> some View {
        self.modifier(ResponsiveSheetContent())
    }
    
    fileprivate func clearSheetSystemBackground() -> some View {
        self.modifier(ClearBackgroundViewModifier())
    }
    
    fileprivate func customCornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        self.modifier(CornerRadiusStyle(radius: radius, corners: corners))
    }
}

//MARK: - EnvironmentKey & Values
fileprivate struct SafeAreaInsetsKey: EnvironmentKey {
    static var defaultValue: EdgeInsets {
        (UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets ?? .zero).insets
    }
}

fileprivate extension EnvironmentValues {
    var safeAreaInsets: EdgeInsets {
        self[SafeAreaInsetsKey.self]
    }
}

//MARK: - UIEdgeInsets Extension
fileprivate extension UIEdgeInsets {
    var insets: EdgeInsets {
        EdgeInsets(top: top, leading: left, bottom: bottom, trailing: right)
    }
}
