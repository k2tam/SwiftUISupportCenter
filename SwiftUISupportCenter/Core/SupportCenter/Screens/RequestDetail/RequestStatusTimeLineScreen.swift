//
//  RequestStatusTimeLineScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 15/12/2023.
//

import SwiftUI

struct RequestStatusTimeLineScreen: View {
    var stepStatusList: [StepStatus]
    let paddingBottomEachStep: CGFloat = 24
    
    var body: some View {
        HiNavigationView{
            ZStack{
                Color.hiTheme.background
                
                VStack {
                    VStack(spacing: 0){
                        ForEach(stepStatusList) { step in
                            RequestProcessWithVLineView(paddingBottom: paddingBottomEachStep, time: step.time, statusTitle: step.name, statusDetail: step.detail)
                        }
                        
                        
                    }
                    .padding(.all, 16)
                    .background(Color.white)
                    
                    Spacer()
                }
                
                
            }
            .hiNavigationTitle("Trạng thái yêu cầu")
           
            
            
        }
    }
}

struct RequestStatusTimeLineScreen_Previews: PreviewProvider {
    static var previews: some View {
        if let supportRequest = dev.supportRequestList?.report[0] {
            RequestStatusTimeLineScreen(stepStatusList: supportRequest.stepStatus)
        }
       
    }
    
}
