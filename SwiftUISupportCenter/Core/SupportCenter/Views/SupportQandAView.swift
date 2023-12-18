//
//  QandAQuestionView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import SwiftUI

struct SupportQandAView: View {
    let qAndAModel: SupportQandAModel
    @State var currentSelectedQandA: SupportQandAItemView? = nil
    var didSelectQandA: (_ qAndA: SupportQandA) -> Void

    
    var body: some View {
        VStack{
            //Title layout
            BlockNavHeader(title: qAndAModel.title) {
                
            }

            //Content layout
            VStack(alignment: .leading){
                ForEach(Array(qAndAModel.listQuestion.enumerated()), id: \.element){index, item in
                    if index == qAndAModel.listQuestion.count - 1 {
                        SupportQandAItemView(isLastItem: true, qAndAQuestion: item, didSelected: manageExpandQAItems )

                    }else {
                        SupportQandAItemView(qAndAQuestion: item, didSelected: manageExpandQAItems)

                    }
                }
            }
            .padding(.all, 16)
            .background(Color.white.cornerRadius(8))
        }
        .padding(.horizontal, 16)
    }
    
    func manageExpandQAItems(supportQandAItemViewSelected: SupportQandAItemView){
        if currentSelectedQandA == nil {
            currentSelectedQandA = supportQandAItemViewSelected
        }else{
            /*If current question selected is different from saved selected question then collapse selected question and
            change selectedQAItem to current question selected
             */
            if currentSelectedQandA != supportQandAItemViewSelected {
                currentSelectedQandA!.isSelected = false
                currentSelectedQandA = supportQandAItemViewSelected
            }
         
        }
        
        withAnimation {
            currentSelectedQandA?.isSelected.toggle()

        }

    }
}





//#Preview {
//    QandAQuestionView()
//        
//}
