//
//  SupportCenterModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation
import SwiftyJSON

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


struct SupportRequestList {
    let report: [SupportRequest]
    
    init(json: JSON) {
        let report = json["data"]["report"].arrayValue.map {
            return SupportRequest(json: $0)
        }
        
        self.report = report
    }
}

struct SupportRequest : Hashable{
    static func == (lhs: SupportRequest, rhs: SupportRequest) -> Bool {
           // Implement the comparison logic based on your requirements
           return lhs.reportId == rhs.reportId
               && lhs.contractNo == rhs.contractNo
               // Add other properties you want to compare
       }

    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(reportId)
    }
    
    let reportId: String
    let contractNo: String
    let reportTypeId: String
    let stepColor: String
    let stepStatus: [StepStatus]
    
    let iconReportType: String
    let infoEmployee: String?
    let contractId: Int
    let checklistType: String
    let reportType: String
    let lastStepName: String
    let isShowBtnCancel: Bool
    let subTypeName: String
    let reportDate: String
    let reportTimeStr: String
    let note: String
    let dateCreated: String
    let reportTime: ReportTime
    
    init(json: JSON){
        let reportId = json["reportId"].stringValue
        let contractNo = json["contractNo"].stringValue
        let reportTypeId = json["reportTypeId"].stringValue
        let stepColor = json["stepColor"].stringValue
        let stepStatus = json["stepStatus"].arrayValue.map {
            return StepStatus(json: $0)
        }
        let iconReportType = json["iconReportType"].stringValue
        let infoEmployee = json["infoEmployee"].string
        let contractId = json["contractId"].intValue
        let checklistType  = json["checklistType"].stringValue
        let reportType = json["reportType"].stringValue
        let lastStepName = json["lastStepName"].stringValue
        let isShowBtnCancel = json["isShowBtnCancel"].boolValue
        let subTypeName = json["subTypeName"].stringValue
        let reportDate = json["reportDate"].stringValue
        let reportTimeStr = json["reportTimeStr"].stringValue
        let note = json["note"].stringValue
        let dateCreated = json["dateCreated"].stringValue
        let reportTime = ReportTime(json: json["reportTime"])
        
        self.reportId = reportId
        self.contractNo = contractNo
        self.reportTypeId = reportTypeId
        self.stepColor = stepColor
        self.stepStatus = stepStatus
        self.iconReportType = iconReportType
        self.infoEmployee = infoEmployee
        self.contractId = contractId
        self.checklistType = checklistType
        self.reportType = reportType
        self.lastStepName = lastStepName
        self.isShowBtnCancel = isShowBtnCancel
        self.subTypeName = subTypeName
        self.reportDate = reportDate
        self.reportTimeStr = reportTimeStr
        self.note = note
        self.dateCreated = dateCreated
        self.reportTime = reportTime
    }
}

struct StepStatus {
    let icon: String
    let textColor: String
    let time: String
    let feedback: String
    let status: String
    let id: String
    let name: String
    let detail: String
    
    init(json: JSON){
        let icon = json["icon"].stringValue
        let textColor = json["textColor"].stringValue
        let time = json["time"].stringValue
        let feedback = json["feedback"].stringValue
        let status = json["status"].stringValue
        let id = json["id"].stringValue
        let name = json["name"].stringValue
        let detail = json["detail"].stringValue
        
        self.icon = icon
        self.textColor = textColor
        self.time = time
        self.feedback = feedback
        self.status = status
        self.id = id
        self.name = name
        self.detail = detail
    }
}

struct ReportTime {
    let begin: String
    let end: String
    
    init(json: JSON){
        self.begin = json["begin"].stringValue
        self.end = json["end"].stringValue

    }
}
