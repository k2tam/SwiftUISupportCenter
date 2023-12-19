//
//  NavigationTagManager.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 18/12/2023.
//

import Foundation


enum eNavTag{
    case toRequestStatusTimeLineScreen
    case toMoreQaAScreen
}


class NavigationTagManager: ObservableObject{
    static let shared =  NavigationTagManager()
    
    private init() {}
    
    
    @Published var navTag: eNavTag? = nil
    
}
