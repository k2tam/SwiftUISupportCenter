//
//  NavigationLinks.swift
//  SupportCenter
//
//  Created by k2 tam on 07/12/2023.
//

import SwiftUI

enum eNavigationTag {
    case toContractsList
}


struct HiNavigationLink: View {
    @Binding var navTag: eNavigationTag?
  
    
    var body: some View {
        Group {
//            NavigationLink(
//                destination: HiNavigationView(content: {
//                    ContractsListScreen()
//                        .hiNavigationTitle("Chọn hợp đồng")
//                })
//                , tag: eNavigationTag.toContractsList
//                , selection: $navTag) {
//                    EmptyView()
//                }
        }
        
    }
}

//#Preview {
//    NavigationLinks()
//}
