//
//  QADataService.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 26/12/2023.
//

import Foundation

class QADataService {
    @Published var listQandA: [SupportQandA] = []
    @Published var isLoading: Bool = true
    
    
    init() {
        self.getListQandA()
    }
    
    func getListQandA() {
        SupportCenterManager.requestQandAQuestionData(completion: {[weak self] result in
            self?.listQandA.append(contentsOf: result?.listQuestion ?? [])
            self?.isLoading = false
        })
    }
}
