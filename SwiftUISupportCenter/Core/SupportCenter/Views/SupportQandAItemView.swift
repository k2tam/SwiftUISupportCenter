//
//  QandAQuestionItem.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import SwiftUI
import SwiftUIBackports

struct SupportQandAItemView: View, Equatable {
    
    let id = UUID().uuidString // Assuming id is an Int property
    static func == (lhs: SupportQandAItemView, rhs: SupportQandAItemView) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    @State var isSelected: Bool = false
    var isLastItem: Bool
    let qAndAQuestion: SupportQandA
    @Backport.StateObject var vm = QAndASupportItemViewModel(didSelectQAKey: nil)
    var didSelected: ((_ supportQandAItemViewSelected: SupportQandAItemView) -> Void)
    
    init(isSelected: Bool = false, isLastItem: Bool = false, qAndAQuestion: SupportQandA, didSelected: @escaping (_: SupportQandAItemView) -> Void) {
        self.isSelected = isSelected
        self.isLastItem = isLastItem
        
        self.qAndAQuestion = qAndAQuestion
        self.didSelected = didSelected
    }
    
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
                    .rotationEffect(self.isSelected ? .degrees(-180) : .degrees(0))
                    .padding(.leading, 16)
                
                
            }
            
            //Content Layout
            if self.isSelected {
                AttributedText(
                    vm.attributedString
                )
                .font(.system(size: 16))
                .foregroundColor(Color.hiTheme.secondaryText)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity)
                .animation(.default)
            }
            
            //Bottom divider line
            if !isLastItem  {
                HiDividerLine()
                    .frame(maxWidth: .infinity, maxHeight: 1)
                    .padding(.bottom, 16)
                
            }
            
        }
        .onTapGesture(perform: {
            self.didSelected(self)
        })
        .onAppear(perform: {
            vm.setUpAnswerTextView(question: qAndAQuestion)
        })
    }
    
    
    
}

//#Preview {
//    QandAQuestionItemView()
//}
