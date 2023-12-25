//
//  SupportScheduleViewModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 21/12/2023.
//

import Foundation
import Combine

class SupportScheduleViewModel: ObservableObject {
    @Published var dateTimeAllowModel: DateTimeAllowModel? = nil{
        didSet {
            setupDate()
        }
    }
    @Published var listTime: [ListTimeSlotModel] = []
    @Published var selectedDate: Date? = nil
    @Published var selectedTime: TimeSlotModel? = nil
    
    
    func setupDate() {
        guard let dateTimeAllowModel else {return}
        self.listTime = dateTimeAllowModel.listTime
        
        
        //Check date allow is valid
        self.checkValidationOfDateAllow(model: dateTimeAllowModel) { isDateValid in
            if isDateValid {
                setDefaultDateTimeIfDateAllowValid(dateTimeAllowModel: dateTimeAllowModel)
            }
            else {
                setDefaultDateTimeIfDateAllowInvalid()
            }
        }
    }
    
    func setDefaultDateTimeIfDateAllowValid(dateTimeAllowModel: DateTimeAllowModel) {
        self.selectedDate = dateTimeAllowModel.dateTimeAllow.parseStringDateToDate()
        
        //Check time is valid
        self.checkValidationOfTimeSelect(dateTimeAllowModel: dateTimeAllowModel, completion: { isTimeValid in
            
            if isTimeValid {
                self.selectedTime = dateTimeAllowModel.timeSelect
                
            }
        })
    }
    
    /// Function to set date time checked on calendar to today and time will be the time as soon as possible
    func setDefaultDateTimeIfDateAllowInvalid() {
        self.selectedDate = Date()
        
            
        timeSlotsIterate: for timeSlot in self.listTime {
            for timeSlotModel in timeSlot.supportTime {
                if timeSlotModel.status == .allow {
                    self.selectedTime = timeSlotModel
                    break timeSlotsIterate
                }
            }
        }
        
    }
    
    func checkValidationOfTimeSelect(dateTimeAllowModel: DateTimeAllowModel, completion: (_ isTimeValid: Bool) -> Void) {
        _ = dateTimeAllowModel.listTime.map { timesInDay in
           
            guard let timeSelect = dateTimeAllowModel.timeSelect else {
                completion(false)
                return
            }
            
            let isTimeSelectValid = timesInDay.supportTime.contains { timeSupport in
                timeSupport.begin == timeSelect.begin &&
                timeSupport.end == timeSelect.end &&
                timeSupport.id == timeSelect.id
            }
            
            completion(isTimeSelectValid)
        }
    }
    
    func checkValidationOfDateAllow(model: DateTimeAllowModel?, completion: (_ isDateValid: Bool) -> Void) {
        guard let model else {
            completion(false)
            return
        }
        
        guard let dateTimeAllowInDate = model.dateTimeAllow.parseStringDateToDate() else {
            completion(false)
            return

        }
        
        //Case dateTimeAllowInDate is in the past
        if dateTimeAllowInDate < Date() {
            completion(false)
            return
        }
        
        completion(true)

    }

}

extension String {
    func parseStringDateToDate() -> Date? {
        // Create a date formatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        // Convert the input date string to a Date object
        guard let date = dateFormatter.date(from: self) else {
            print("Failed to parse date string to date")
            return nil
        }
        
        return date
    }
    
}
