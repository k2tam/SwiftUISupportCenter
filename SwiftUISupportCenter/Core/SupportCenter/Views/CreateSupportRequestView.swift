//
//  CreateSupportRequestView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI

struct CreateSupportRequestView: View {
     let supportRequestCategories: [eSupportRequestCategory]
    let selectCategoryCallBack: (_ :eSupportRequestCategory) -> Void
    
    var body: some View {
        VStack(alignment: .leading){
            //Block Title
            BlockNavHeader(title: "Tạo yêu cầu hỗ trợ")
            
            Spacer()
                .frame(height: 24)
                
            //Content
            HStack(spacing: 16){
                ForEach(supportRequestCategories, id: \.self){ item in
                    Button(action: {
                        selectCategoryCallBack(item)
                    }, label: {
                        RequestCategory(title: item.title(), image: item.imageString())
                    })
                    .buttonStyle(PlainButtonStyle())
                    
                        
                }

            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(EdgeInsets(top: 16, leading: 16, bottom: 0, trailing: 16))
    }
}

struct RequestCategory: View {
    let title: String
    let image: String
    
    var body: some View {
        VStack(spacing: 8){
            HiImage(string: image)
                .frame(width: 40, height: 40)
                .cornerRadius(8)
            
            Text(title)
                .font(.system(size: 14))
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 8)
        .background(Color.white.cornerRadius(8))
    }
}

struct CreateSupportRequestView_Preview: PreviewProvider {
    static var previews: some View {
        CreateSupportRequestView(supportRequestCategories: dev.createSupportRequestCategories, selectCategoryCallBack: dev.didSelectSupportRequestCategory)
            .previewLayout(.sizeThatFits)
    }

}


