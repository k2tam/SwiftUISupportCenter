//
//  SupportRequestCategory.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation

//Enum cho block tạo yêu cầu hỗ trợ
enum eSupportRequestCategory {
    case technical
    case procedure
    case fee
    case feedBack
    
    func title() -> String {
        switch self {
        case .technical:
            return "Kỹ thuật"
        case .procedure:
            return "Thủ tục"
        case .fee:
            return "Cước phí"
        case .feedBack:
            return "Góp ý"
        }
    }
    
    func imageString() -> String {
        switch self {
        case .technical:
            return "ic_technical"
        case .procedure:
            return "ic_procedure"
        case .fee:
            return "ic_fee"
        case .feedBack:
            return "ic_feedback"
        }
    }
}
