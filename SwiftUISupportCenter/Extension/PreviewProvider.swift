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
    
    var dateTimeModel: DateTimeAllowModel? = nil
    
    var previewSupportCenterVM = SupportCenterViewModel()
    
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
        
        
        self.getSupportScheduleData { result in
            self.dateTimeModel = result
        }
    }
    
    let createSupportRequestCategories: [eSupportRequestCategory] = [.technical,.procedure,.fee,.feedBack]
    
    
    //TODO: Handle selected support request category
    func didSelectSupportRequestCategory(category: eSupportRequestCategory) {
        switch category {
        case .technical:
            print("Hỗ trợ kỹ thuật")
        case .procedure:
            print("Hỗ trợ thủ tục")

        case .fee:
            print("Hỗ trợ cước phí")
        case .feedBack:
            print("Góp ý")
        }
    }
    
    
    
    private func getSupportScheduleData(completion: @escaping(_ result: DateTimeAllowModel?) -> Void) {
        guard let data = DateTimeAllowSampleData.sampleData.data(using: .utf8) else {
            completion(nil)
            return
        }
        
        do{
            let json = try JSON(data: data)
            completion(DateTimeAllowModel(json: json["data"]))
        } catch {
            print("Error parsing JSON: \(error)")
            completion(nil)
            
        }
    }
    
}
