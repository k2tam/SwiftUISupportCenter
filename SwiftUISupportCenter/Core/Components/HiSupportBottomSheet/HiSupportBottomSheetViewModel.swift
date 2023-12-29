//
//  HiSupportBottomSheetViewModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import Foundation
import Combine

struct SelectionModel {
    var id: Int
    let title: String
    var isSelected: Bool = false
}

struct BottomSheetServices: Identifiable {
    var id: Int
    var title: String
    var isSelected: Bool = false
}


class HiSupportBottomSheetViewModel: ObservableObject {
    @Published var currentSelections: [SelectionModel] = []
    @Published var selectedId: Int = 5
    
    @Published var selectedServiceId: Int? = nil
    @Published var services: [BottomSheetServices] = []
////        didSet {
////            if !services.isEmpty && selectedId{
////                selectedId = services.
////            }
////        }
//    }
    
    private var cancelables = Set<AnyCancellable>()
    
    
    init() {
        self.currentSelections = [
            SelectionModel(id: 0, title: "Nâng cấp dịch vụ"),
            SelectionModel(id: 1, title: "Chuyển địa điểm dịch vụ"),
            SelectionModel(id: 2, title: "Khôi phục dịch vụ"),
            SelectionModel(id: 3, title: "Tạm dừng / ngưng dịch vụ"),
            SelectionModel(id: 4, title: "Không truy cập được"),
            SelectionModel(id: 5, title: "Khác"),
            
        ]
        
        self.services = [
            BottomSheetServices(id: 1,title: "Internet"),
            BottomSheetServices(id: 2,title: "Truyền hình"),
            BottomSheetServices(id: 3, title: "Camera"),
            BottomSheetServices(id: 4, title: "Thiết bị"),
        ]
        
        
        
        addSelectedIdSubscriber()
    }
    
    private func addSelectedIdSubscriber() {
        $selectedId
            .sink { selectedId in
                self.currentSelections =  self.currentSelections.map { selectionModel in
                    if selectionModel.id == selectedId {
                        return SelectionModel(id: selectionModel.id, title: selectionModel.title, isSelected: true)
                    }else {
                        return SelectionModel(id: selectionModel.id, title: selectionModel.title, isSelected: false)
                    }
                    
                }
            }
            .store(in: &cancelables)
    }
}
