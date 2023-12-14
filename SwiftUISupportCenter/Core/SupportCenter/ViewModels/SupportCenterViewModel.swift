//
//  SupportCenterViewModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation


class SupportCenterViewModel: ObservableObject {
    let createSupportRequestCategories: [eSupportRequestCategory] = [.technicalSupport,.feeProcedures,.customerCare]
    @Published var supportRequestList: SupportRequestList? = nil
    @Published var supportExtensionList: [SupportExtension]? = nil
    @Published var qAndAQuestionModel: QandASupportModel? = nil
    
    init() {
        SupportCenterManager.requestSupportRequestListData(completion: { result in
            self.supportRequestList = result
        })
        
        SupportCenterManager.requestSupportExtensionsData { result in
            self.supportExtensionList = result
        }
        
        SupportCenterManager.requestQandAQuestionData { result in
            self.qAndAQuestionModel = result
        }
    }
    
   
    
    
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
    
    //TODO: Handle selected support extension here
    func didSelectSupportExtension(action: NavigationModel){
        print(action.dataAction)
    }
}
