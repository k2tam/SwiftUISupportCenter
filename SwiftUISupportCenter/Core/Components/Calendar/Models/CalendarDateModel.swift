//
//  CalendarDateModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 20/12/2023.
//

import Foundation

enum CalendarDateType {
    case UnableDay
    case TodayAble
    case TodayUnable
    case AbleDay
    case SelectedDay
}

struct CalendarDateModel {
    var type: CalendarDateType?
    var date: Date
    var isChecked: Bool = false
    var isToday: Bool = false
    var weekDay: WeekdayType
    var day: String
    
    init(date: Date){
        self.date = date
        let weekday = WeekdayType(rawValue: self.date.getWeekdayNumber())
        self.weekDay = weekday ?? .Mon
        self.type = date.setCalendarDateType()
        self.day = String(date.getIntDay())
    }
    
    init(date: Date, day: String){
        self.date = date
        let weekday = WeekdayType(rawValue: self.date.getWeekdayNumber())
        self.weekDay = weekday ?? .Mon
        self.type = date.setCalendarDateType()
        self.day = day
    }
 
}
 
extension Date {
    func setCalendarDateType() -> CalendarDateType{
        if self.string() == Date().string() {
            return .AbleDay
        }
        
        if self >= Date() {
            return .AbleDay
        }
        
        return .UnableDay
    }
}

//Value weekday of Swift Callendar library
enum WeekdayType:Int{
    case Sun = 1
    case Mon = 2
    case Tue = 3
    case Web = 4
    case Thu = 5
    case Fri = 6
    case Sat = 7
    
//    func getWeekDayFromEnum()->String{
//        switch (self){
//        case .Sun:
//            return Localizable.shared.localizedString(key: "CN")
//        case .Mon:
//            return Localizable.shared.localizedString(key: "T2")
//        case .Tue:
//            return Localizable.shared.localizedString(key: "T3")
//        case .Web:
//            return Localizable.shared.localizedString(key: "T4")
//        case .Thu:
//            return Localizable.shared.localizedString(key: "T5")
//        case .Fri:
//            return Localizable.shared.localizedString(key: "T6")
//        case .Sat:
//            return Localizable.shared.localizedString(key: "T7")
//
//        }
//    }
}
