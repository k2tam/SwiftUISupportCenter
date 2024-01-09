//
//  HiSupportBottomSheetViewModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import Foundation
import Combine

enum SupServiceType {
    case internet
    case tv
    case camera
}

struct SupProblem: Equatable, Identifiable {
    var id: Int
    let title: String
    var supServiceType: SupServiceType

    
    static func == (lhs: SupProblem, rhs: SupProblem) -> Bool {
        return lhs.id == rhs.id && lhs.supServiceType == rhs.supServiceType
        }
}

struct BottomSheetSupportService: Identifiable, Equatable {
    var id: Int
    var title: String
    var problems: [SupProblem]
    
    static func == (lhs: BottomSheetSupportService, rhs: BottomSheetSupportService) -> Bool {
            return lhs.id == rhs.id
        }
}


class HiSupportBottomSheetViewModel: ObservableObject {
    @Published var currentProblems: [SupProblem] = []
    @Published var selectedProblem: SupProblem? = nil {
        didSet {
            print(selectedProblem)
        }
    }
    
    @Published var selectedService: BottomSheetSupportService? = nil {
        didSet {
            currentProblems = selectedService?.problems ?? []
        }
    }

    @Published var services: [BottomSheetSupportService] = [] {
        didSet {
            //Auto select first service
            if !services.isEmpty && selectedService == nil{
                selectedService = services.first
            }
        }
    }

    private var cancelables = Set<AnyCancellable>()
    
    init(services: [BottomSheetSupportService]){
        self.services = services
        addSelectedIdSubscriber()
    }
     
    init(problems: [SupProblem]){
        self.currentProblems = problems
        addSelectedIdSubscriber()
    }

    init() {
        self.services = SupBottomSheetSampleData.supportServices
        addSelectedIdSubscriber()
    }
    
    private func addSelectedIdSubscriber() {
        $selectedProblem
            .sink {[weak self]  selectedId in
                guard let self else {return}
                
                 self.currentProblems.map { problem in
                    if problem == self.selectedProblem {
                        return SupProblem(id: problem.id, title: problem.title, supServiceType: problem.supServiceType)
                    }else {
                        return SupProblem(id: problem.id, title: problem.title, supServiceType: problem.supServiceType)
                    }
                    
                }
            }
            .store(in: &cancelables)
    }
}
