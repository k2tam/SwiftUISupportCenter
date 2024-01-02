//
//  Playground.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import SwiftUI
import SwiftBackports

struct Playground: View {
    
    @State  var isShow: Bool = false
    var body: some View {
        ZStack {
            Button(action: {
                isShow.toggle()
            }, label: {
                Text("Toggle")
            })
            
//            HiSupportBottomSheet(isShow: $isShow, heightOfEachItem: 56, showServicesBar: true)
            
            HiSupportBottomSheet(isShow: $isShow
                                 , heightOfEachItem: 56, supServices: SupBottomSheetSampleData.supportServices)
            
//            HiSupportBottomSheet(isShow: $isShow
//                                 , heightOfEachItem: 56, supProblems: SupBottomSheetSampleData.tvProblems)
        }
    }
}

#Preview {
    Playground(isShow: false)
}
