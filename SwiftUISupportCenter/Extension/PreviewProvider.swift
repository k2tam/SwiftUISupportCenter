//
//  PreviewProvider.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation
import SwiftUI
import SwiftyJSON

extension PreviewProvider {
    static var dev: DeveloperPreview {
        return DeveloperPreview.shared
    }
    
}

class DeveloperPreview {
    static let shared = DeveloperPreview()
    
    var supportRequestList: SupportRequestList? = nil
    var supportExtensionList: [SupportExtension]? = nil
    
    
     func previewRequestSupportRequestListData() {
        
        guard let data = SupportRequestListSampleData.sampleData.data(using: .utf8) else {
            return
        }
        
        do {
            let json = try JSON(data: data)
            self.supportRequestList =  SupportRequestList(json: json)
        } catch {
            print("Error parsing JSON: \(error)")
            return
        }
        
    }
    
    private init() {
        previewRequestSupportRequestListData()
        
      
        
        
        SupportCenterManager.requestSupportExtensionsData { result in
            self.supportExtensionList = result
        }
    }
    
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
