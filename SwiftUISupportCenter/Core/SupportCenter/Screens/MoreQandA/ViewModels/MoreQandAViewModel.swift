//
//  MoreQandAViewViewModel.swift
//  SupportCenter
//
//  Created by k2 tam on 10/11/2023.
//

import Foundation

class MoreQandAViewModel: ObservableObject {
    @Published var selectedQuestionID: Int = 0
    @Published var searchText: String = ""
    @Published var listQandA: [SupportQandA] = []
    @Published var currentSelectedQandA: SupportQandAItemView? = nil

    
    init() {
        self.fetchListSupportCategory()
    }
    
    func fetchListSupportCategory() {
        SupportCenterManager.requestQandAQuestionData(completion: { result in
            self.listQandA.append(contentsOf: result?.listQuestion ?? [])

        })
    }
    
    

}
