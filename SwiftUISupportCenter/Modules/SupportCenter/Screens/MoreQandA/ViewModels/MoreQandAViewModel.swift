//
//  MoreQandAViewViewModel.swift
//  SupportCenter
//
//  Created by k2 tam on 10/11/2023.
//

import Foundation
import Combine

class MoreQandAViewModel: ObservableObject {
    @Published var selectedQandA: SupportQandA? = nil
    @Published var searchText: String = ""
    @Published var listQandA: [SupportQandA] = []
    @Published var filteredListQandA: [SupportQandA] = []
    @Published var isLoading: Bool = true
    
    private var qADataService = QADataService()
    
    private var cancellables =  Set<AnyCancellable>()
    
    var isSearching: Bool {
        return !searchText.isEmpty
    }
    
    init() {
        self.addSubscribers()
    }
    
    private func addSubscribers() {
        $searchText
            .sink {[weak self] searchText in
                self?.filterSupportQandAQuestion(searchText: searchText)
                
            }
            .store(in: &cancellables)
        
        
        self.qADataService.$listQandA
            .sink(receiveValue: {[weak self] returnedListQA in
                self?.listQandA = returnedListQA
            })
            .store(in: &cancellables)
        
        self.qADataService.$isLoading
            .sink(receiveValue: { [weak self] returnedIsLoading in
                self?.isLoading = returnedIsLoading
            })
            .store(in: &cancellables)

            

    }
    

    
    func filterSupportQandAQuestion(searchText: String) {
        guard !searchText.isEmpty else {
            filteredListQandA = []
            return
        }
        
        let search = searchText.lowercased()
        self.filteredListQandA =  listQandA.filter { question in
            
            let normalizedQuestion = question.question.folding(options: .diacriticInsensitive, locale: .current)
            let normalizedContent = question.content.folding(options: .diacriticInsensitive, locale: .current)
            let normalizedSearch = search.folding(options: .diacriticInsensitive, locale: .current)
            
            let isQuestionContainsSearch = normalizedQuestion.localizedCaseInsensitiveContains(normalizedSearch)
            let isContentContainsSearch =  normalizedContent.localizedCaseInsensitiveContains(normalizedSearch)
            return isQuestionContainsSearch || isContentContainsSearch
        }
        
        
    }
    
    
    //Bo dau cua string
    
    
    
    
}
