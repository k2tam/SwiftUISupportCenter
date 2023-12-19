//
//  SwiftUISupportCenterApp.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI
import SwiftBackports

struct SwiftUISupportCenterApp: View {
    @Backport.StateObject var navManager = NavigationTagManager.shared
    var body: some View {
        SupportCenterScreen()
            .environmentObject(navManager)
    }
}
