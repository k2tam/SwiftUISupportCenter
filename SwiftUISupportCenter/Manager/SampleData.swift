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
      "statusCode" : 0,
      "message" : "Thành công",
      "data" : {
        "report" : [
          {
            "reportId" : 17699018,
            "contractNo" : "SGAAS3387",
            "reportTypeId" : "1",
            "stepColor" : "#728AB1",
            "stepStatus" : [
              {
                "icon" : "https://www.google.com/search?q=icon&sca_esv=578407962&tbm=isch&sxsrf=AM9HkKlfFa83MhaDtVfskqNQTNEoTBUQAw:1698824911143&source=lnms&sa=X&ved=2ahUKEwjoyfT6p6KCAxXvklYBHUJDA7gQ_AUoAXoECAEQAw&biw=1680&bih=947&dpr=2#imgrc=pdB6fkDtOiqkaM",
                "textColor" : "#333333",
                "time" : "20/03/2023\n13:51",
                "feedback" : "",
                "status" : "complete",
                "id" : "9",
                "name" : "Đã hủy",
                "detail" : ""
              },
              {
                "icon" : "",
                "textColor" : "#969696",
                "time" : "06/02/2023\n17:42",
                "feedback" : "",
                "status" : "complete",
                "id" : "3",
                "name" : "Đã tiếp nhận yêu cầu ",
                "detail" : ""
              },
              {
                "icon" : "",
                "textColor" : "#969696",
                "time" : "06/02/2023\n17:42",
                "feedback" : "",
                "status" : "complete",
                "id" : "1",
                "name" : "Đã gửi yêu cầu",
                "detail" : ""
              }
            ],
            "iconReportType" : "",
            "infoEmployee" : null,
            "contractId" : 1090055503,
            "checklistType" : "",
            "reportType" : "HT-KYTHUAT",
            "lastStepName" : "Đã hủy",
            "isShowBtnCancel" : false,
            "subTypeName" : "Không truy cập được internet",
            "reportDate" : "2023-02-06",
            "reportTimeStr" : "06/02/2023, 18:00-19:00",
            "note" : "",
            "dateCreated" : "06/02/2023",
            "reportTime" : {
              "begin" : "18:00",
              "end" : "19:00"
            }
          }
        ]
      }
    }
    
    """
}
