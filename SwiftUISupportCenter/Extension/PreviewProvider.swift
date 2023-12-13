//
//  PreviewProvider.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation
import SwiftUI

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
    
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    private init() {}
    
    let createSupportRequestCategories: [eSupportRequestCategory] = [.customerCare,.feeProcedures,.technicalSupport]
    
    //TODO: Handle selected support request category
    func didSelectSupportRequestCategory(category: eSupportRequestCategory) {
        switch category {
        case .technicalSupport:
            print("Hỗ trợ kỹ thuật")
        case .feeProcedures:
            print("Thủ tục cước phí")
        case .customerCare:
            print("Chăm sóc khác hàng")
        }
    }
    
}
