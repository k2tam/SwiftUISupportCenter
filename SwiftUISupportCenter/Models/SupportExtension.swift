//
//  SupportExtensions.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation
import SwiftyJSON

enum FontWeight: String {
    case medium
    case regular
    
    func fontWeight() -> FontWeight {
        switch self {
        case .medium:
            return FontWeight.medium
        case .regular:
            return FontWeight.regular
        }}
    }


struct SupportExtension: Identifiable, Hashable {
    let id = UUID()
    let name: String
    let nameColor: String
    let backgroundColor: String
    let borderWidth: Float
    let borderColor: String
    let roundCorner: Float
    let fontWeight: FontWeight
    let iconUrl: String
    let action: NavigationModel
    let opacity: Float
    let keyTracking: String
    let type: String
    
    init(json: JSON) {
        let name = json["name"].stringValue
        let nameColor = json["nameColor"].string ?? "#333333"
        let backgroundColor = json["backgroundColor"].string ?? "#FFFFFF"
        let fontWeight = FontWeight(rawValue: json["fontWeight"].stringValue) ?? .regular
        let iconUrl = json["iconUrl"].stringValue
        let actionJson = NavigationModel(fromJSON: json["action"])
        let borderWidth = json["borderWidth"].floatValue
        let borderColor = json["borderColor"].string ?? "#FFFFFF"
        let roundCorner = json["roundCorner"].float ?? 8.0
        let opacity = json["opacity"].float ?? 1.0
        let keyTracking = json["keyTracking"].stringValue
        let type = json["type"].stringValue

        self.name = name
        self.nameColor = nameColor
        self.backgroundColor = backgroundColor
        self.fontWeight = fontWeight
        self.iconUrl = iconUrl
        self.action = actionJson
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.roundCorner = roundCorner
        self.opacity = opacity
        self.keyTracking = keyTracking
        self.type = type
    }
}

struct NavigationModelData: Hashable{
    let channel: String
    
    init(json: JSON){
        self.channel = json["channel"].stringValue
    }
}
struct NavigationModel : Hashable{
    let dataAction: String
    let data: NavigationModelData
    let actionType: String
    
    init(fromJSON json: JSON){
        self.dataAction = json["dataAction"].stringValue
        self.data = NavigationModelData(json: json["data"])
        self.actionType = json["actionType"].stringValue
    }
}
