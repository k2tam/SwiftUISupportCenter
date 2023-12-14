//
//  QandAQuestion.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import Foundation
import SwiftyJSON

struct QandASupportModel{
    var totalPage: Int
    var perPage: Int
    var title: String
    var currentPage: Int
    var listQuestion: [QandASupport] = []
    
    init(json: JSON){
        self.totalPage = json["totalPage"].intValue
        self.perPage = json["perPage"].intValue
        self.title = json["Title"].stringValue
        self.currentPage = json["currentPage"].intValue
        
        self.listQuestion = json["ListQuestion"].arrayValue.map{
            return QandASupport(json: $0)
        }
    }
    
}

class QandASupport: Identifiable, Hashable{
    static func == (lhs: QandASupport, rhs: QandASupport) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var id: Int
    var question: String
    var content: String
    var keys: [KeyContentModel]
    var isSelected: Bool = false
    var keyTracking: String
    
    init(json: JSON){
        self.id = json["id"].intValue
        self.keyTracking = json["keyTracking"].stringValue
        self.question = json["question"].stringValue
        self.content = json["content"].stringValue
        self.keys = json["keys"].arrayValue.map{
            contentJson in
            return KeyContentModel(json: contentJson)
        }
    }
    
}

struct KeyContentModel {
    let text: String
    let textColor: String
    let action: NavigationModel
    let fontWeight: FontWeight
    var textAction: QandATextAction
    var textUnderline: Bool
    
    init(json: JSON){
        text = json["text"].stringValue
        textColor = json["textColor"].stringValue
        action = NavigationModel(fromJSON: json["action"])
        fontWeight = FontWeight(rawValue: json["fontWeight"].stringValue) ?? .regular
        textAction = QandATextAction(rawValue: json["textAction"].stringValue) ?? .NONE
        textUnderline = json["textUnderline"].boolValue
    }
}

struct QATextAndAction{
    let text: String
    let action: NavigationModel
}


enum QandATextAction: String{
    case CALL
    case NONE
}
