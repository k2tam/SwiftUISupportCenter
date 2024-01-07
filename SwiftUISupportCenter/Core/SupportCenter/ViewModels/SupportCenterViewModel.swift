//
//  SupportCenterViewModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation


class SupportCenterViewModel: ObservableObject {
    let createSupportRequestCategories: [eSupportRequestCategory] = [.technical,.procedure,.fee,.feedBack]
    @Published var supportRequestList: SupportRequestList? = nil
    @Published var supportExtensionList: [SupportExtension]? = nil
    
    @Published var qAndAQuestionModel: SupportQandAModel? = nil
    @Published var selectedQuestion: SupportQandA? = nil {
        didSet {
            if let selectedQuestion = selectedQuestion {
                self.didSelectQandASupport(selectedQandA: selectedQuestion)
            }
        }
    }
    
    @Published var isLoadingSupportRequestList = true
    @Published var isLoadingSupportExtensionsData = true
    @Published var isLoadingQandAQuestionData = true
    
    
    
    init() {
        SupportCenterManager.requestSupportRequestListData(completion: {[weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingSupportRequestList = false
                self?.supportRequestList = result

            }
        })
        
        SupportCenterManager.requestSupportExtensionsData {[weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingSupportExtensionsData = false
                self?.supportExtensionList = result
            }
        }
    
        
        SupportCenterManager.requestQandAQuestionData {[weak self] result in
            DispatchQueue.main.async {
                self?.isLoadingQandAQuestionData = false
                self?.qAndAQuestionModel = result
            }
        }
    }
    
   
    
    
    //TODO: Handle selected support request category 
    func didSelectSupportRequestCategory(category: eSupportRequestCategory) {
        switch category {
        case .technical:
            NavigationTagManager.shared.navTag = .toSupportRequestScreen
            print("Hỗ trợ kỹ thuật")
        case .procedure:
            NavigationTagManager.shared.navTag = .toProcedureRequestScreen
            print("Thủ tục")
        case .fee:
            print("Thủ tục cước phí")
        case .feedBack:
            print("Góp ý")
        }
    }
    
    //TODO: Handle selected support extension here
    func didSelectSupportExtension(action: NavigationModel){
        print(action.dataAction)
    }
    
    //TODO: Handle selected Q&ASupport extension here
    func didSelectQandASupport(selectedQandA: SupportQandA) {
        print(selectedQandA.id)
        
    }

}
