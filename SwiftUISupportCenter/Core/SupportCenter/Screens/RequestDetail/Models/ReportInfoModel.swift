//
//  ReportInfoModel.swift
//  Hi FPT
//
//  Created by Nghia Dao on 14/05/2023.
//

//import Foundation
//import SwiftyJSON
//
//struct ReportInfoModel{
//    var checklistType: String?
//    var imgSupportType : String
//    var isShowBtnCancel : Bool
//    var reportId : Int
//    var reportType : ReportTypeEmum
//    var reportTypeId : String
//    var reportDate : String //"2022-12-07"
//    var reportTime : TimeSlotModel //"15:00-18:00"
//    var reportName : String
//    var subTypeName : String
//    var contractNo : String
//    var contractId : Int
//    var lastNameStep : String
//    var lastStepIcon: String
//    var lastStepColor : String
//    var backGroundColor : String
//    var dateCreated : String
//    var reportTimeStr : String
//    var note : String
//    var employeeRequest : String
//    var infoEmployee : EmployeeSupportModel?
//    var reportInfo : RequestSupportReportInfo?
//    var contractInfo : RequestSupportContractInfo
//    var stepStatus : [RequestSupportStepStatus]
//    var dateLastUpdate : String // History
//    var isShowBtnChangeReportTime : Bool
//    var statusRedirect: reportStatusRedirectType = .call
//    var feedback:SupportFeedbackModel?
//    var isShowButtonSurvey: Bool
//    var isShowButtonEditTime: Bool
//    var lastStepTime: String
//    var isColapse:Bool = true
//    var customerSurveyType: String
//    var extendData: ExtendDeviceDataModel?
//    var iconReportType: String
//    var newAddress: String
//    var stepColor: String
//    var apiType: ApiGetTimeType
//    var subReason: String
//    var surveyAction: NavigationModel
//    var stepColorBackground: String
//    var isShowPopupEarlyAssignment: Bool
//    var popupEarlyAssignmentInfo: PopupEarlyAssignmentInfoModel?
//    
//    init(json:JSON){
//        isShowBtnCancel = json["isShowBtnCancel"].bool ?? false
//        imgSupportType = json["reportTypeImage"].stringValue
//        reportId = json["reportId"].intValue
//        reportType = ReportTypeEmum.init(rawValue: json["reportType"].stringValue) ?? .TECH
//        reportTypeId = json["reportTypeId"].stringValue
//        reportName = json["reportName"].stringValue
//        subTypeName = json["subTypeName"].stringValue
//        contractNo = json["contractNo"].stringValue
//        contractId = json["contractId"].intValue
//        lastNameStep = json["lastStepName"].stringValue
//        lastStepColor = json["lastStepColor"].stringValue
//        backGroundColor = json["backGroundColor"].stringValue
//        dateCreated = json["dateCreated"].stringValue
//        reportTimeStr = json["reportTimeStr"].stringValue
//        note = json["note"].stringValue
//        reportDate = json["reportDate"].stringValue
//        reportTime = TimeSlotModel(json: json["reportTime"])
//        employeeRequest = json["employeeRequest"].stringValue
//        customerSurveyType = json["customerSurveyType"].stringValue
//
//        infoEmployee = EmployeeSupportModel().parseEmployeeSupport(json: json["infoEmployee"])
//        reportInfo = RequestSupportReportInfo.initFromJson(json: json["reportInfo"])
//        contractInfo = RequestSupportContractInfo(json: json["contractInfo"])
//        var tempStepStatus = [RequestSupportStepStatus]()
//        for item in json["stepStatus"].arrayValue{
//            tempStepStatus.append(RequestSupportStepStatus(json: item))
//        }
//        stepStatus = tempStepStatus
//        dateLastUpdate = json["dateLastUpdate"].stringValue
//        isShowBtnChangeReportTime = json["isShowBtnChangeReportTime"].boolValue
//        isShowButtonEditTime =  json["isShowButtonEditTime"].boolValue
//        lastStepIcon = json["lastStepIcon"].stringValue
//        
//        if json["feedback"].null !=  NSNull() {
//            self.feedback = SupportFeedbackModel(json: json["feedback"])
//            self.statusRedirect = .call
//        }else{
//            self.statusRedirect = .detail
//        }
//        
//        isShowButtonSurvey = json["isShowButtonSurvey"].boolValue
//        
//        lastStepTime  = json["lastStepTime"].stringValue
//        
//        if json["extend"].null !=  NSNull() {
//            extendData = ExtendDeviceDataModel(json: json["extend"])
//        }
//        
//        iconReportType  = json["iconReportType"].stringValue
//        checklistType = json["checklistType"].string
//        newAddress  = json["newAddress"].stringValue
//        stepColor  = json["stepColor"].stringValue
//        apiType = ApiGetTimeType(rawValue: json["apiType"].stringValue) ?? .create
//        subReason = json["subReason"].stringValue
//        surveyAction = NavigationModel(fromJSON: json["surveyAction"])
//        stepColorBackground = json["stepColorBackground"].stringValue
//        isShowPopupEarlyAssignment = json["isShowPopupEarlyAssignment"].boolValue
//        popupEarlyAssignmentInfo = PopupEarlyAssignmentInfoModel(dataJS: json["popupEarlyAssignmentInfo"])
//    }
//    
//    static func parseToArray(fromJSON arrayJS: [JSON]) -> [ReportInfoModel] {
//        return arrayJS.map { itemJS in
//            return ReportInfoModel(json: itemJS)
//        }
//    }
//    
//}
//
//struct RequestSupportReportInfo{ //reportInfo
//    var fullName : String //"fullName": "Acc nghiep vu test modem cua CN Ben Thanh",
//    var phone : String // "phone": "0387854404"
//    static func initFromJson(json:JSON) -> RequestSupportReportInfo?{
//       if json == JSON.null{
//           return nil
//       }else{
//           return RequestSupportReportInfo(fullName: json["fullName"].stringValue, phone: json["phone"].stringValue)
//       }
//    }
//}
//
//struct RequestSupportContractInfo{//contractInfo
//    var contractNo : String // "SGDN00107",
//    var fullName : String // "Acc nghiep vu test modem cua CN Ben Thanh",
//    var contractPhone : String // "0289301280",
//    var address : String // "68 Vo Van Tan"
//    init(json: JSON){
//        contractNo = json["contractNo"].stringValue
//        fullName = json["fullName"].stringValue
//        contractPhone = json["contractPhone"].stringValue
//        address = json["address"].stringValue
//    }
//}
//
//struct RequestSupportStepStatus{
//    var id : String //"3",
//    var name : String //"Đã tiếp nhận yêu cầu ",
//    var time : String //"",
//    var status : RequestSupportStepStatusType? //"complete"
//    var icon: String
//    var textColor: String
//    var textTimeColor: String
//    var textDetailColor: String
//    var textDetailFontWeight: UIFont.Weight
//    var textNameFontWeight: UIFont.Weight
//    var detail: String
//    var feedback: String
//    
//    init(json:JSON){
//        id = json["id"].stringValue
//        name = json["name"].stringValue
//        time = json["time"].stringValue
//        icon = json["icon"].stringValue
//        textTimeColor = json["textTimeColor"].stringValue
//        textDetailColor = json["textTimeColor"].stringValue
//        textDetailFontWeight = TextFont.init(rawValue : json["textDetailFontWeight"].stringValue.lowercased())?.parseToFontWeight() ?? UIFont.Weight.regular
//        textNameFontWeight = TextFont.init(rawValue : json["textNameFontWeight"].stringValue.lowercased())?.parseToFontWeight() ?? UIFont.Weight.regular
//        textColor = json["textColor"].stringValue
//        status = RequestSupportStepStatusType.init(rawValue: json["status"].stringValue)
//        detail = json["detail"].stringValue
//        feedback = json["feedback"].stringValue
//    }
//}
//
//enum RequestSupportStepStatusType: String{
//    case complete = "complete" //: trạng thái ẩn đã thành công
//    
//    case final_success = "final-success" //: trạng thái cuối cùng và thành công – tích xanh
//    
//    case final_cancel = "final-cancel" //: trạng thái cuối cùng nhưng thất bại – tích đỏ
//    
//}
//struct SupportFeedbackModel{
//    var phone: String
//    var text: String
//
//    init(json: JSON){
//        self.phone = json["phone"].stringValue
//        self.text = json["text"].stringValue
//    }
//}
//
//enum ReportFilterStatusType: String{
//    case PROCESSING
//    case RECEIVED
//    case ALL
//}
//
//enum  reportStatusRedirectType: String {
//    case call
//    case detail
//}
//
//struct PopupEarlyAssignmentInfoModel{
//    var title: String
//    var description: String
//    var textDenyBtn: String
//    var textAcceptBtn: String
//    
//    init(title: String, description: String, textDenyBtn: String, textAcceptBtn: String) {
//        self.title = title
//        self.description = description
//        self.textDenyBtn = textDenyBtn
//        self.textAcceptBtn = textAcceptBtn
//    }
//    
//    init(dataJS: JSON){
//        self.title = dataJS["title"].stringValue
//        self.description =  dataJS["description"].stringValue
//        self.textDenyBtn = dataJS["textDenyBtn"].stringValue
//        self.textAcceptBtn = dataJS["textAcceptBtn"].stringValue
//    }
//}
