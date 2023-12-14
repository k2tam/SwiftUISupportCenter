//
//  QandAQuestionView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import SwiftUI

struct QandAQuestionView: View {
    let qAndAModel: QandASupportModel
    @State var selectedQAItem: QandASupport? = nil

    
    var body: some View {
        VStack{
            //Title layout
            BlockTitle(title: "Câu hỏi thường gặp") {
                
            }

            //Content layout
            VStack(alignment: .leading){
                ForEach(Array(qAndAModel.listQuestion.enumerated()), id: \.element){index, item in
                    
                    VStack(spacing: 16){
                        QandAQuestionItemView(qAndAQuestion: item)
                            .onTapGesture(perform: {
                                qAndAModel.listQuestion[index].isSelected 
                            })

                        //Bottom divider line
                        if index != qAndAModel.listQuestion.count - 1  {
                            HiDividerLine()
                                .frame(maxWidth: .infinity, maxHeight: 1)
                                .padding(.bottom, 16)
                        }
                    }
                   
                    
                }
            }
            .padding(.all, 16)
            .background(Color.white.cornerRadius(8))
        }
        .padding(.horizontal, 16)
    }
    
    func manageExpandQAItems(item: QandASupport){
        if selectedQAItem == nil {
            selectedQAItem = item
        }else{
            /*If current question selected is different from saved selected question then collapse selected question and
            change selectedQAItem to current question selected
             */
            if selectedQAItem != item {
                selectedQAItem!.isSelected = false
                selectedQAItem = item
            }
         
        }
        
        selectedQAItem?.isSelected.toggle()
    }
}





//#Preview {
//    QandAQuestionView()
//        
//}
