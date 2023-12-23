//
//  QandAQuestionItem.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import SwiftUI
import SwiftUIBackports

struct SupportQandAItemView: View {
    
    var isLastItem: Bool = false
    let qAndAQuestion: SupportQandA
    @Binding var selectedQuestion: SupportQandA?
    
    @Backport.StateObject var vm = QAndASupportItemViewModel(didSelectQAKey: nil)

    var didSelected: ((_ selectedQuestion: SupportQandA) -> Void)
    
    @State var isExpand: Bool = false
    
    // Additional state variable to track changes
    @State private var selectedQuestionChanged: Bool = false
    
 
    
    var body: some View {
        VStack(spacing: 16){
            //Question layout
            HStack{
                Text("Cách nào để kiểm tra Internet trong nhà có an toàn, bảo mật không?")
                    .font(.system(size: 16))
                    .multilineTextAlignment(.leading)
                
                Spacer()
                
                HiImage(string: "ic_arrow_down")
                    .frame(width: 24, height: 24)
                    .rotationEffect(self.isExpand ? .degrees(-180) : .degrees(0))
                    .padding(.leading, 16)
                
                
            }
            
            //Content Layout
            if self.isExpand {
                AttributedText(
                    vm.attributedString
                )
                .font(.system(size: 16))
                .foregroundColor(Color.hiTheme.secondaryText)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
                    
                
//                Text("Hi")
            }
            
            //Bottom divider line
            if !isLastItem  {
                HiDividerLine()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .padding(.bottom, 16)
                
            }
            
        }
        .onTapGesture(perform: {
            withAnimation {
                self.isExpand.toggle()
            }
                self.selectedQuestion = qAndAQuestion
        })
        .onAppear(perform: {
            vm.setUpAnswerTextView(question: qAndAQuestion)
            
        })
        .backport.onChange(of: selectedQuestion) { newSelectedQuestion in
            if newSelectedQuestion == nil{
                return
            }
            
            withAnimation {
                if  newSelectedQuestion?.id != qAndAQuestion.id {
                    self.isExpand = false
                }
            }
           
            

        }
    }
    
    func selectedCharacterRangeCallBack(range: NSRange){
        vm.handleTapKeys(range: range, question: qAndAQuestion)
    }
    
    
    
}



//#Preview {
//    
//    
//    
//    SupportQandAItemView(qAndAQuestion: <#SupportQandA#>, selectedQuestion: <#Binding<SupportQandA?>#>, didSelected: <#(SupportQandA) -> Void#>)
//}
