//
//  SupportExtensionsView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI
import Kingfisher

struct SupportExtensionsView: View {
    var supportExtensionsList: [SupportExtension]
    let didSelectSupportExtension: (_ action: NavigationModel) -> Void
    
    var body: some View {
        HStack(spacing: 16){
            ForEach(supportExtensionsList, id: \.self) { item in
                Button(action: {
                    didSelectSupportExtension(item.action)
                }, label: {
                    SupportExtensionView(supportExtension: item)
                })
                .buttonStyle(PlainButtonStyle())
            }
        }
        .frame(height: 80)
        .padding(.horizontal, 16)
    }
}

struct SupportExtensionView: View {
    let supportExtension: SupportExtension
    var body: some View {
        HStack(alignment: .top){
           Text("Chat\nvới CSKH")
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Color.blue
                .frame(width: 24, height: 24)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.all, 16)
        .background(Color(hex: supportExtension.backgroundColor).cornerRadius(CGFloat(supportExtension.roundCorner)))
    }
}



//struct SupportExtensionsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SupportExtensionsView(supportExtensionsList: dev.supportExtensionList ?? [], didSelectSupportExtension: <#() -> Void#>)
//    }
//}
