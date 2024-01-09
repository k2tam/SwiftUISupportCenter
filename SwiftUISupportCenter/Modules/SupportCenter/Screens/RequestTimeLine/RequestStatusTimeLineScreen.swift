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
                Color.hiBackground
                
                VStack {
                    ScrollView{
                        VStack(spacing: 0){
                            ForEach(Array(stepStatusList.enumerated()), id: \.element.id) {index, step in
                                RequestProcessWithVLineView(
                                    isLastProcess: index == stepStatusList.count - 1 ? true : false,
                                    paddingBottom: paddingBottomEachStep,
                                    time: step.time,
                                    statusTitle: step.name,
                                    statusDetail: step.detail
                                )
                            }
                            
                            
                        }
                        .padding(.all, 16)
                        .background(Color.white)
                        .cornerRadius(8)
                        .padding(.horizontal, 16)
                        .padding(.top, 16)
                        
                    }
                    
                    
                    Spacer()
                }
                
                
            }
            .hiNavigationTitle("Trạng thái yêu cầu")
            .edgesIgnoringSafeArea(.bottom)
            
            
            
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
