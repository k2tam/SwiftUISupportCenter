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
    
    @Published var qAndAQuestionModel: SupportQandAModel? = nil
    @Published var selectedQuestion: SupportQandA? = nil {
        didSet {
            
            print(selectedQuestion?.content)
        }
    }
    
    init() {
        SupportCenterManager.requestSupportRequestListData(completion: {[weak self] result in
            DispatchQueue.main.async {
                self?.supportRequestList = result

            }
        })
        
        SupportCenterManager.requestSupportExtensionsData {[weak self] result in
            DispatchQueue.main.async {
                self?.supportExtensionList = result
            }
        }
        
        SupportCenterManager.requestQandAQuestionData {[weak self] result in
            DispatchQueue.main.async {
                self?.qAndAQuestionModel = result
            }
        }
    }
    
   
    
    
    //TODO: Handle selected support request category 
    func didSelectSupportRequestCategory(category: eSupportRequestCategory) {
        switch category {
        case .technicalSupport:
            NavigationTagManager.shared.navTag = .toSupportRequestScreen
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
    
    //TODO: Handle selected Q&ASupport extension here
//    func didSelectQandASupport(selectedQandA: SupportQandA) {
//        self.selectedQuestion = selectedQandA
//        
//    }

}
