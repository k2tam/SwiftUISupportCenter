//
//  TextView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import Foundation
import SwiftUI
import SwiftUIBackports

struct TextViewWrapper: UIViewRepresentable {
    var attributedText: NSAttributedString
    var maxLayoutWidth: CGFloat
    var textViewStore: TextViewStore

    func makeUIView(context: Context) -> TextView {
        
        let uiView = TextView()
        
        uiView.backgroundColor = .clear
        uiView.textContainerInset = .zero
        uiView.isEditable = false
        uiView.isScrollEnabled = false
        uiView.textContainer.lineFragmentPadding = 0
        
        return uiView
    }
    
    func updateUIView(_ uiView: TextView, context: Context) {
        uiView.attributedText = attributedText
         uiView.maxLayoutWidth = maxLayoutWidth
         
         uiView.textContainer.maximumNumberOfLines = context.environment.lineLimit ?? 0
         uiView.textContainer.lineBreakMode = NSLineBreakMode(context.environment.truncationMode)
         
         DispatchQueue.main.async {
             textViewStore.didUpdateTextView(uiView)
         }
    }
}

final class TextView: UITextView {
    var maxLayoutWidth: CGFloat = 0 {
        didSet {
            guard maxLayoutWidth != oldValue else { return }
            invalidateIntrinsicContentSize()
        }
    }
    
    override var intrinsicContentSize: CGSize {
        guard maxLayoutWidth > 0 else {
            return super.intrinsicContentSize
        }

        return sizeThatFits(
            CGSize(width: maxLayoutWidth, height: .greatestFiniteMagnitude)
        )
    }
}

extension GeometryProxy {
    var maxWidth: CGFloat {
        size.width - safeAreaInsets.leading - safeAreaInsets.trailing
    }
}


struct AttributedText: View {
    @Backport.StateObject private var textViewStore = TextViewStore()
    private let attributedText: NSMutableAttributedString
    
    init(_ attributedText: NSMutableAttributedString) {
        self.attributedText = attributedText
    }
    
    var body: some View {
        GeometryReader { geometry in
            TextViewWrapper(
                attributedText: attributedText,
                maxLayoutWidth: geometry.maxWidth,
                textViewStore: textViewStore
            )
        }
        .frame(height: textViewStore.height)
    }
}


final class TextViewStore: ObservableObject {
    @Published private(set) var height: CGFloat?
    
    func didUpdateTextView(_ textView: TextView) {
        height = textView.intrinsicContentSize.height
    }
}

extension NSLineBreakMode {
    init(_ truncationMode: Text.TruncationMode) {
        switch truncationMode {
        case .head:
            self = .byTruncatingHead
        case .tail:
            self = .byTruncatingTail
        case .middle:
            self = .byTruncatingMiddle
        @unknown default:
            self = .byWordWrapping
        }
    }
}

