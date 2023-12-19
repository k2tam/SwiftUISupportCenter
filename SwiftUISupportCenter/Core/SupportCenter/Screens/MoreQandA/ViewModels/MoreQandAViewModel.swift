//
//  MoreQandAViewViewModel.swift
//  SupportCenter
//
//  Created by k2 tam on 10/11/2023.
//

import Foundation

class MoreQandAViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var listQandA: [SupportQandA] = []
    
    
    func fetchListSupportCategory() {
        SupportCenterManager.requestQandAQuestionData(completion: { result in
            self.listQandA.append(contentsOf: result?.listQuestion ?? [])

        })
    }
    
    

}
