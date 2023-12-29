//
//  SupBottomSheetSampleData.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import Foundation

struct SupBottomSheetSampleData {
    static let internetProblems: [SupProblem] = [
        SupProblem(id: 0, title: "Nâng cấp dịch vụ", supServiceType: .internet),
        SupProblem(id: 1, title: "Chuyển địa điểm dịch vụ", supServiceType: .internet),
     
    ]
    
    static let tvProblems: [SupProblem] = [
        SupProblem(id: 0, title: "Nâng cấp truyền hình", supServiceType: .tv),
        SupProblem(id: 1, title: "Chuyển địa điểm dịch vụ", supServiceType: .tv),
        SupProblem(id: 2, title: "Khôi phục dịch vụ", supServiceType: .tv),
        SupProblem(id: 3, title: "Tạm dừng / ngưng dịch vụ", supServiceType: .tv),
        SupProblem(id: 4, title: "Không truy cập được", supServiceType: .tv),
    ]
    
    static let cameraProblems: [SupProblem] = [
        SupProblem(id: 0, title: "Nâng cấp camera", supServiceType: .camera),
        SupProblem(id: 1, title: "Không truy cập được", supServiceType: .camera),
        SupProblem(id: 2, title: "Camera bị mờ", supServiceType: .camera),

    ]
    
    static let supportServices: [BottomSheetSupportService] = [
        BottomSheetSupportService(id: 1, title: "Internet", problems: internetProblems),
        BottomSheetSupportService(id: 2, title: "Truyền hình", problems: tvProblems),
        BottomSheetSupportService(id: 3, title: "Camera", problems: cameraProblems),
    ]
}
