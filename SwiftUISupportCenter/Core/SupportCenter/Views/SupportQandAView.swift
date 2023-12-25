//
//  QandAQuestionView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import SwiftUI

struct SupportQandAView: View {
    @EnvironmentObject var navManager: NavigationTagManager
    
    let qAndAModel: SupportQandAModel
    @Binding var selectedQuestion: SupportQandA?
    

    var body: some View {
        VStack{
            //Title layout
            BlockNavHeader(title: qAndAModel.title) {
                navManager.navTag = .toMoreQaAScreen
            }

            //Content layout
            VStack(alignment: .leading){
                ForEach(Array(qAndAModel.listQuestion.enumerated()), id: \.element){index, item in
                    if index == qAndAModel.listQuestion.count - 1 {
                        SupportQandAItemView(isLastItem: true,qAndAQuestion: item, selectedQuestion: $selectedQuestion)

                    }else {
                        SupportQandAItemView(qAndAQuestion: item, selectedQuestion: $selectedQuestion)

                    }
                }
            }
            .padding(.all, 16)
            .background(Color.white.cornerRadius(8))
        }
        .padding(.horizontal, 16)
    }
    

}







