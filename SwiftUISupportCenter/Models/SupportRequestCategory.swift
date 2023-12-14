//
//  SupportRequestCategory.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation

//Enum cho block tạo yêu cầu hỗ trợ
enum eSupportRequestCategory {
    case technicalSupport
    case feeProcedures
    case customerCare
    
    func title() -> String {
        switch self {
        case .technicalSupport:
            return "Hỗ trợ\nkỹ thuật"
        case .feeProcedures:
            return "Thủ tục\ncước phí"
        case .customerCare:
            return "Chăm sóc\nkhách hàng"
        }
    }
    
    func imageString() -> String {
        switch self {
        case .technicalSupport:
            return "ic_technical_support"
        case .feeProcedures:
            return "ic_fee_procedures"
        case .customerCare:
            return "ic_customer_care"
        }
    }
}
