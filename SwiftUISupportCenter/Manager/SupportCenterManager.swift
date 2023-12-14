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
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
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
    
    static func requestSupportExtensionsData(completion: @escaping(_ result: [SupportExtension]?) -> Void) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
            guard let data = SupportExtensionsSampleData.sampleData.data(using: .utf8) else {
                completion(nil)
                return
            }
            
            do {
                let json = try JSON(data: data)
                completion(
                    json["data"].arrayValue.map({
                        SupportExtension(json: $0)
                    })
                )
            } catch {
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        }
    }
    
    static func requestQandAQuestionData(completion: @escaping(_ result: QandASupportModel?) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            guard let data = QAndAQuestionSampleData.sampleData.data(using: .utf8) else {
                completion(nil)
                return
            }
            
            do {
                let json = try JSON(data: data)
                completion(QandASupportModel(json: json["data"]))
            }catch{
                print("Error parsing JSON: \(error)")
                completion(nil)
            }
        }
    }
    
}
