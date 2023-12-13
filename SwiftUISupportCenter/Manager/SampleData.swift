//
//  SampleData.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import Foundation


struct SupportRequestListSampleData {
    static let sampleData = """
     {
       "statusCode": 0,
       "message": "Thành công",
       "data": {
         "report": [
           {
             "reportId": 17699018,
             "contractNo": "SGAAS3387",
             "reportTypeId": "1",
             "stepColor": "#728AB1",
             "stepStatus": [
               {
                 "icon": "",
                 "textColor": "#333333",
                 "time": "20/03/202313:51",
                 "feedback": "",
                 "status": "complete",
                 "id": "9",
                 "name": "Đã hủy",
                 "detail": ""
               },
               {
                 "icon": "",
                 "textColor": "#969696",
                 "time": "06/02/202317:42",
                 "feedback": "",
                 "status": "complete",
                 "id": "3",
                 "name": "Đã tiếp nhận yêu cầu ",
                 "detail": ""
               },
               {
                 "icon": "",
                 "textColor": "#969696",
                 "time": "06/02/202317:42",
                 "feedback": "",
                 "status": "complete",
                 "id": "1",
                 "name": "Đã gửi yêu cầu",
                 "detail": ""
               }
             ],
             "iconReportType": "",
             "infoEmployee": null,
             "contractId": 1090055503,
             "checklistType": "",
             "reportType": "HT-KYTHUAT",
             "lastStepName": "Đã hủy",
             "isShowBtnCancel": false,
             "subTypeName": "Không truy cập được internet",
             "reportDate": "2023-02-06",
             "reportTimeStr": "06/02/2023, 18:00-19:00",
             "note": "",
             "dateCreated": "06/02/2023",
             "reportTime": {
               "begin": "18:00",
               "end": "19:00"
             }
           }
         ]
       }
     }
    """
}
