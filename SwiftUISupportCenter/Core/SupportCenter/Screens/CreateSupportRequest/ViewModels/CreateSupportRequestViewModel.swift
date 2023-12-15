//
//  CreateSupportRequestViewModel.swift
//  SupportCenter
//
//  Created by k2 tam on 14/11/2023.
//

import Foundation

enum eContractService {
    case internet
    case tvInternet
    case camera
    
    func serviceText() -> String{
        switch self {
        case .internet:
            return "Internet"
        case .tvInternet:
            return "Internet - Truyền hình"
        case .camera:
            return "Camera"
        }
    }
}

enum eSupportStatus {
    case cantSeeCameraOnApp
    case badResolution
    case cantReplay
    case errorDevice
    case maintain
    
    func statusText() -> String {
        switch self {
        case .cantSeeCameraOnApp:
            return "Không xem được Camera trên ứng dụng"
        case .badResolution:
            return "Hình ảnh bị giật, xé hình, chất lượng, hình ảnh kém"
        case .cantReplay:
            return "Không xem lại được"
        case .errorDevice:
            return "Lỗi thiết bị (thiết bị không lên nguồn)"
        case .maintain:
            return "Bảo trì theo yêu cầu"
        }
    }
}


class CreateSupportRequestViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    @Published var note: String = ""
    
    @Published var wasSubmitRequest = false
    
    var contractTags = ["Chính chủ","Combo Internet","Camera"]
    
    
    func submitSupportRequest() {
        DispatchQueue.main.async {
            self.wasSubmitRequest = true
            print(self.fullName)
            print(self.phoneNumber)
        }
      
    }

}
