//
//  DateTimeModel.swift
//  Hi FPT
//
//  Created by Nghia Dao on 12/7/22.
//

import Foundation
import SwiftyJSON
 
class DateTimeAllowModel: ObservableObject{
    var listTime: [ListTimeSlotModel]
    var dateTimeAllow: String
    var dateAllow: String
    var isSkipTime: Bool
    var timeSelect: TimeSlotModel? = nil
    var isShowButtonChat: Bool
    var showTimeReport : Bool

    init(json: JSON){
        self.dateTimeAllow = json["dateTimeAllow"].stringValue
        self.dateAllow = json["dateAllow"].stringValue
        var temp: [ListTimeSlotModel] = []
        temp.append(contentsOf: json["listTime"].arrayValue.map{
            return ListTimeSlotModel(json: $0)
        })
        self.listTime = temp
        
        self.isSkipTime = (json["buttonTimeSkip"].intValue == 1)
        
        
        if json["timeSelect"].null != NSNull(){
            self.timeSelect = TimeSlotModel(json: json["timeSelect"])
        }
        
        self.isShowButtonChat = json["isShowButtonChat"].boolValue
        self.showTimeReport = json["showTimeReport"].boolValue
    }
}

struct ListTimeSlotModel: Identifiable {
    var id = UUID()
    var title: String = ""
    var iconType: TimeSlotIconType = .morning
    var supportTime: [TimeSlotModel] = []
    
    init(json: JSON){
        self.title =  json["title"].stringValue
        self.iconType = TimeSlotIconType(rawValue: json["iconType"].stringValue) ?? .morning
        var temp: [TimeSlotModel] = []
        temp.append(contentsOf: json["dataTime"].arrayValue.map{return TimeSlotModel(json: $0)})
        self.supportTime = temp
    }
}

struct TimeSlotModel: Identifiable{
    let id: Int
    var begin: String
    var end: String
//    var employeeData: [EmplModel]
    var status: TimeSlotStatus = .deny
    
    // Implement Equatable
   static func ==(lhs: TimeSlotModel, rhs: TimeSlotModel) -> Bool {
       return lhs.id == rhs.id &&
              lhs.begin == rhs.begin &&
              lhs.end == rhs.end
   }
    
    init(json: JSON){
        self.id = json["timeId"].intValue
        self.begin = json["begin"].stringValue
        self.end = json["end"].stringValue
//        var temp: [EmplModel] = []
//        temp.append(contentsOf: json["listInfoEmployee"].arrayValue.map{return EmplModel(json: $0)})
        
//        self.employeeData = nil
//        self.employeeData = temp
        self.status = TimeSlotStatus(rawValue: json["timeStatus"].stringValue) ?? .deny
    }
    
//    init( begin: String,end: String){
//        self.begin = begin
//        self.end = end
//        self.status = .allow
//    }
//    
//    init?(begin: String?,end: String?){
//        guard let begin = begin,
//        let end = end else{
//            return nil
//        }
//        
//        self.begin = begin
//        self.end = end
//        self.status = .allow
//    }
}

//struct EmplModel:HiThemesImageTitleIconProtocol{
//    var cellId: String = NSUUID().uuidString
//    var cellType: HiThemesPopupWithListItemCellType
//    var iconCheck: UIImage?
//    var iconUncheck: UIImage?
//    
//    
//    var empId: String = ""
//    var empName: String = ""
//    var empPosition: String = ""
//    var empStar: String = ""
//    var empAvatar: String = ""
//    var isSelected: Bool = false
//        
//    init(json: JSON) {
//        
//        self.empId = json["empId"].stringValue
//        self.empName = json["empName"].stringValue
//        self.empPosition = json["empPosition"].stringValue
//        self.empStar = json["empStar"].stringValue
//        self.empAvatar = json["empAvatar"].stringValue
//        self.isSelected = false
//        
//        let attributesTitles: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor(red: 0.157, green: 0.157, blue: 0.157, alpha: 1),
//            .font: UIFont.systemFont(ofSize: 14, weight: .medium) ?? UIFont()
//        ]
//        
//        let attributesSubTitles: [NSAttributedString.Key: Any] = [
//            .foregroundColor: UIColor(red: 0.463, green: 0.463, blue: 0.463, alpha: 1),
//            .font: UIFont.systemFont(ofSize: 12, weight: .regular) ?? UIFont()
//        ]
//        
//        self.cellType = HiThemesPopupWithListItemCellType.Image_Title_SubTitle_IconChecked(iconItem: self.empAvatar, title: NSMutableAttributedString(string: self.empName,attributes: attributesTitles), subTitle: NSMutableAttributedString(string: self.empPosition,attributes: attributesSubTitles),isEnable: true)
////        self.iconCheck = UIImage(named: "ic_select_radio")
////        self.iconUncheck = UIImage(named: "ic_unselect_radio")
//        
//    }
//        
//}

enum TimeSlotIconType:String{
    case morning
    case afternoon
    case night
}

enum TimeSlotStatus:String{
    case allow
    case warning
    case deny
}

enum MonthType:Int{
    case Jan = 1
    case Feb = 2
    case Mar = 3
    case Apr = 4
    case May = 5
    case June = 6
    case July = 7
    case Aug = 8
    case Sep = 9
    case Oct = 10
    case Nov = 11
    case Dec = 12
    
//    func getMonthType()->String{
//        switch(self){
//        case .Jan:
//            return Localizable.shared.localizedString(key: "Thg1")
//        case .Feb:
//            return Localizable.shared.localizedString(key: "Thg2")
//        case .Mar:
//            return Localizable.shared.localizedString(key: "Thg3")
//        case .Apr:
//            return Localizable.shared.localizedString(key: "Thg4")
//        case .May:
//            return Localizable.shared.localizedString(key: "Thg5")
//        case .June:
//            return Localizable.shared.localizedString(key: "Thg6")
//        case .July:
//            return Localizable.shared.localizedString(key: "Thg7")
//        case .Aug:
//            return Localizable.shared.localizedString(key: "Thg8")
//        case .Sep:
//            return Localizable.shared.localizedString(key: "Thg9")
//        case .Oct:
//            return Localizable.shared.localizedString(key: "Thg10")
//        case .Nov:
//            return Localizable.shared.localizedString(key: "Thg11")
//        case .Dec:
//            return Localizable.shared.localizedString(key: "Thg12")
//        }
//    }
}

enum ApiGetTimeType: String{
    case create
    case update
    case updateCheckList
    case getTimeReportCharge
}
