//
//  QAndASupportViewModel.swift
//  SupportCenter
//
//  Created by k2 tam on 09/11/2023.
//

import Foundation
import SwiftUI

class QAndASupportItemViewModel: ObservableObject {
    var keyRanges:[NSRange] = []
    @Published var attributedString: NSMutableAttributedString = NSMutableAttributedString()

    var didSelectQAKey: ((_ QAKey: QATextAndAction) -> Void)?
    
    init(didSelectQAKey: ((_ QAKey: QATextAndAction) -> Void)?){
        self.didSelectQAKey = didSelectQAKey
    }
    
    func setUpAnswerTextView(question: SupportQandA) {
        let str = question.content
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 7 // Set the desired line height here
        
        let attributeString = NSMutableAttributedString(string: str, attributes: [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular),
            //            NSAttributedString.Key.foregroundColor: Color(hex: "#333333"),
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        let substring = "{key}"
        
        var range = (attributeString.string as NSString).range(of: substring)
        var fullRange = NSRange(location: 0, length: attributeString.string.utf8.count)
        var index = 0
        
        while NSIntersectionRange(range, fullRange).length != 0{
            
            if index == question.keys.count {
                break
            }
            
            let keyData = question.keys[index]
            let insertText = keyData.text
            
            attributeString.replaceCharacters(in: range, with: insertText)
            var fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
            
            
            switch(keyData.fontWeight){
            case.regular:
                fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .regular)]
            case.medium:
                fontAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14, weight: .medium)]
            }
            
            //            let colorAttributes = [NSAttributedString.Key.foregroundColor: Color(hex: keyData.textColor)]
            //            let colorAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: "#2552E0")]
            let newRangeAfterInsert = NSRange(location: range.location ,length: insertText.count )
            
            if (keyData.textUnderline){
                let unitUnderline = [ NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue ]
                attributeString.addAttributes( unitUnderline, range: newRangeAfterInsert)
            }
            
            attributeString.addAttributes( fontAttributes, range: newRangeAfterInsert)
            //            attributeString.addAttributes( colorAttributes, range: newRangeAfterInsert)
            
            
            keyRanges.append(newRangeAfterInsert)
            
            
            range = (attributeString.string as NSString).range(of: substring)
            fullRange = NSRange(location: 0, length: attributeString.string.count)
            index += 1
        }
        
        
        
        self.attributedString = attributeString
    }
    
    func handleTapKeys(range: NSRange, question: SupportQandA){
//         Check if the character index is within the bounds of the attributed string
        if let index = keyRanges.firstIndex(where: {
            (range.location >= $0.location ) &&  (range.location <= ($0.location + $0.length) )
        }){
            guard let key = question.keys[safe: index] else{
                return
            }
            switch key.textAction{
            case .CALL:
//                key.text.makeACall()
                print("call")
            case .NONE:
//                self.callbackRedirect?(key.action)
                print("rediresct")
            }
            
            let qaKeySelected = QATextAndAction(text: key.text, action: key.action)
            
            
            self.didSelectQAKey?(qaKeySelected)
            
        }
    }
    
}


extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
