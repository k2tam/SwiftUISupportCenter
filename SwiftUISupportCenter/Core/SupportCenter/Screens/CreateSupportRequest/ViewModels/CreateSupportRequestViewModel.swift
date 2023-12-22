//
//  CreateSupportRequestViewModel.swift
//  SupportCenter
//
//  Created by k2 tam on 14/11/2023.
//

import Foundation
import Combine

enum eContractService {
    case internet
    case tvInternet
    case camera
    
    func serviceText() -> String{
        switch self {
        case .internet:
            return "Internet"
        case .tvInternet:
            return "Internet - Truyền hình"
        case .camera:
            return "Camera"
        }
    }
}

enum eSupportStatus {
    case cantSeeCameraOnApp
    case badResolution
    case cantReplay
    case errorDevice
    case maintain
    
    func statusText() -> String {
        switch self {
        case .cantSeeCameraOnApp:
            return "Không xem được Camera trên ứng dụng"
        case .badResolution:
            return "Hình ảnh bị giật, xé hình, chất lượng, hình ảnh kém"
        case .cantReplay:
            return "Không xem lại được"
        case .errorDevice:
            return "Lỗi thiết bị (thiết bị không lên nguồn)"
        case .maintain:
            return "Bảo trì theo yêu cầu"
        }
    }
}


class CreateSupportRequestViewModel: ObservableObject {
    @Published var fullName: String = ""
    @Published var phoneNumber: String = ""
    @Published var note: String = ""
    @Published var calendarLabelText = ""
    
    
    
    @Published var selectedDate: String = ""
    @Published var selectedTime: TimeSlotModel? = nil
    @Published var dateTimeAllowModel: DateTimeAllowModel? = nil
    @Published var wasSubmitRequest = false
    
    private let dateTimeAllowService = DateTimeAllowDataService()
    private var cancelables = Set<AnyCancellable>()
    

    
    var contractTags = ["Chính chủ","Combo Internet","Camera"]
    
    init() {
        addSubscribersForDateTimeAllowModel()
    }
    
    //TODO: Handle date and time support selected here
    func didGetDateAndTimeSupport(date: String, time: TimeSlotModel) {
        self.selectedDate = date
        self.selectedTime = time
        
        print("tambnk: \(date)")
        print("tambnk: \(time)")
        
        self.setCalendarTextLabel(date: date, beginTime: time.begin, endTime: time.end)
    }
    
    func addSubscribersForDateTimeAllowModel() {
        self.dateTimeAllowService.$dateTimeAllowModel
            .sink {[weak self] returnedDateTimeAllowModel in
                guard let self else {return}
                
                self.dateTimeAllowModel = returnedDateTimeAllowModel
                
                
                self.setCalendarTextLabel(
                    date: dateTimeAllowModel?.dateTimeAllow,
                    beginTime: dateTimeAllowModel?.timeSelect?.begin,
                    endTime: dateTimeAllowModel?.timeSelect?.end
                
                )
            }
            .store(in: &cancelables)
    }
    
    func setCalendarTextLabel(date: String?, beginTime: String?, endTime: String?) {
        guard let date, let beginTime, let endTime else {return}
        
        self.calendarLabelText = " \(date) (\(beginTime)-\(endTime))"
    }
    
    
    func submitSupportRequest() {
        DispatchQueue.main.async {
            self.wasSubmitRequest = true
            print(self.fullName)
            print(self.phoneNumber)
        }
      
    }
    
    
    

}
