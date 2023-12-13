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
    
    init() {
        SupportCenterManager.requestSupportRequestListData(completion: { result in
            self.supportRequestList = result
        })
        
        
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
}
