//
//  SupportScheduleViewModel.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 21/12/2023.
//

import Foundation
import Combine




class SupportScheduleViewModel: ObservableObject {
    @Published var dateTimeAllowModel: DateTimeAllowModel? = nil
    @Published var listTime: [ListTimeSlotModel] = []
    @Published var selectedDate: Date? = nil
    @Published var selectedTime: TimeSlotModel? = nil
    
    private let dateTimeAllowService = DateTimeAllowDataService()
    private var cancelables = Set<AnyCancellable>()
    
    
    init() {
        addSubscribers()
    }
    
    func addSubscribers() {
        
        self.dateTimeAllowService.$dateTimeAllowModel
            .sink {[weak self] returnedDateTimeModel in
                
                guard let returnedDateTimeModel, let self else {
                    return
                }
                
                self.dateTimeAllowModel = returnedDateTimeModel
                self.listTime = returnedDateTimeModel.listTime
                
                
                //Check date allow is valid
                self.checkValidationOfDateAllow(model: returnedDateTimeModel) { isDateValid in
                    if isDateValid {
                        self.selectedDate = returnedDateTimeModel.dateTimeAllow.parseStringDateToDate()
                        
                        //Check time is valid
                        self.checkValidationOfTimeSelect(dateTimeAllowModel: returnedDateTimeModel, completion: { isTimeValid in
                            
                            if isTimeValid {
                                self.selectedTime = returnedDateTimeModel.timeSelect
                                
                            }
                        })
                        
                    }
                }
            }
            .store(in: &cancelables)
    }
    
    func checkValidationOfTimeSelect(dateTimeAllowModel: DateTimeAllowModel, completion: (_ isTimeValid: Bool) -> Void) {
        dateTimeAllowModel.listTime.map { timesInDay in
           
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
