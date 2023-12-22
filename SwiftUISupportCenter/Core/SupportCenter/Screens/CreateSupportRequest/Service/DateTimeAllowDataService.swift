//
//  DateTimeAllowDataService.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 21/12/2023.
//

import Foundation
import SwiftyJSON



class DateTimeAllowDataService {
    @Published var dateTimeAllowModel: DateTimeAllowModel? = nil
    
    init() {
        self.getSupportScheduleData { returnedDateTimeAllowModel in
            self.dateTimeAllowModel = returnedDateTimeAllowModel
        }
    
    }
    
    private func getSupportScheduleData(completion: @escaping(_ result: DateTimeAllowModel?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0){
            guard let data = DateTimeAllowSampleData.sampleData.data(using: .utf8) else {
                completion(nil)
                return
            }
            
            do{
                let json = try JSON(data: data)
                completion(DateTimeAllowModel(json: json["data"]))
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)

            }
        }
    }
    
    
}


struct DateTimeAllowSampleData {
    static let sampleData = """
    {
      "statusCode" : 0,
      "message" : "Thành công",
      "data" : {
        "timeSelect" : {
          "timeStatus" : "allow",
          "end" : "17:00",
          "begin" : "16:00",
          "timeId" : 17,
          "listInfoEmployee" : [

          ]
        },
        "buttonTimeSkip" : 0,
        "dateTimeAllow" : "20/12/2023",
        "isShowButtonChat" : false,
        "listTime" : [
          {
            "iconType" : "morning",
            "dataTime" : [
              {
                "timeStatus" : "deny",
                "end" : "09:00",
                "begin" : "08:00",
                "timeId" : 9,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "deny",
                "end" : "10:00",
                "begin" : "09:00",
                "timeId" : 10,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "allow",
                "end" : "11:00",
                "begin" : "10:00",
                "timeId" : 11,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "allow",
                "end" : "12:00",
                "begin" : "11:00",
                "timeId" : 12,
                "listInfoEmployee" : [

                ]
              }
            ],
            "title" : "Sáng"
          },
          {
            "iconType" : "afternoon",
            "dataTime" : [
              {
                "timeStatus" : "deny",
                "end" : "13:00",
                "begin" : "12:00",
                "timeId" : 13,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "allow",
                "end" : "14:00",
                "begin" : "13:00",
                "timeId" : 14,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "allow",
                "end" : "15:00",
                "begin" : "14:00",
                "timeId" : 15,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "allow",
                "end" : "16:00",
                "begin" : "15:00",
                "timeId" : 16,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "allow",
                "end" : "17:00",
                "begin" : "16:00",
                "timeId" : 17,
                "listInfoEmployee" : [

                ]
              }
            ],
            "title" : "Chiều"
          },
          {
            "iconType" : "night",
            "dataTime" : [
              {
                "timeStatus" : "deny",
                "end" : "18:00",
                "begin" : "17:00",
                "timeId" : 18,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "deny",
                "end" : "19:00",
                "begin" : "18:00",
                "timeId" : 19,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "deny",
                "end" : "20:00",
                "begin" : "19:00",
                "timeId" : 20,
                "listInfoEmployee" : [

                ]
              },
              {
                "timeStatus" : "deny",
                "end" : "21:00",
                "begin" : "20:00",
                "timeId" : 21,
                "listInfoEmployee" : [

                ]
              }
            ],
            "title" : "Tối"
          }
        ],
        "defaultEmployee" : {
          "empPosition" : "Nhân viên",
          "empAvatar" : "",
          "empName" : "FPT Telecom"
        },
        "showTimeReport" : true,
        "dateAllow" : "2023-12-20"
      }
    }
    
    """
}
