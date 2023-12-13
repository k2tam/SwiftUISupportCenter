//
//  SupportCenterManager.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftyJSON
import Foundation

struct SupportCenterManager {
    public static var shared = SupportCenterManager()
    
    static func requestSupportRequestListData(completion: @escaping(_ result: SupportRequestList?) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2){
            guard let data = SupportRequestListSampleData.sampleData.data(using: .utf8) else {
                completion(nil)
                return
            }
            
            do {
                let json = try JSON(data: data)
                completion(SupportRequestList(json: json))
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        }
    }
}
