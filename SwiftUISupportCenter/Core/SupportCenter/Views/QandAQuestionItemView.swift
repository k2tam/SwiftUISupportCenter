//
//  QandAQuestionItem.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 14/12/2023.
//

import SwiftUI

struct QandAQuestionItemView: View {
    let qAndAQuestion: QandASupport
    
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
                    .padding(.leading, 16)

            }
            
            //Content Layout
            if qAndAQuestion.isSelected {
                Text("Để được thông tin về chính sách, ưu đãi hoặc hỗ trợ thủ tục, cước phí và đăng kí dịch vụ, bạn có thể gọi điện thoại đến số 19006600")
                    .font(.system(size: 16))
                    .foregroundColor(Color.hiTheme.secondaryText)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity)
                    .padding(.bottom, 16)
            }
            
            
           

    
        }
    }
}

//#Preview {
//    QandAQuestionItemView()
//}
