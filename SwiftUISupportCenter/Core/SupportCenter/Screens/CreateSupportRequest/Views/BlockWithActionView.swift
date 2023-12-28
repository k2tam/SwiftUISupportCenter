//
//  BlockWithActionView.swift
//  SupportCenter
//
//  Created by k2 tam on 15/11/2023.
//

import SwiftUI


struct BlockWithActionView : View{
    let icon: String
    let title: String
    let subTitle: String
    let selectionText: String
    let selectionIcon: String
    let action: (() -> Void)
    
    
    init(icon: String, title: String, subTitle: String,selectionText: String, selectionIcon: String, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.subTitle = subTitle
        self.selectionText = selectionText
        self.selectionIcon = selectionIcon
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            BlockTitle(icon: self.icon, title: self.title)
            
            HiDividerLine()
                .padding(.vertical, 16)
            
            Text(subTitle)
                .font(.system(size: 16))
                .foregroundColor(Color.hiSecondaryText)
                .padding(.bottom, 12)
            
            Button {
                action()
            } label: {
                HStack{
                    Text(selectionText)
                        .font(Font.system(size: 14))
                    Spacer()
                    
              
                    HiImage(string: selectionIcon)
                        .frame(width: 24, height: 24)
                
      
                    
                    
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(
                   RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.strokePrimary, lineWidth: 1)
                )
                .foregroundColor(Color.black)
                
                
                
            }
            
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
        
        
        
        
        
    }
}


#Preview {
    BlockWithActionView(icon: "ic_state", title: "Tình trạng", subTitle: "Tình trạng", selectionText: "Mạng Wifi không ổn định", selectionIcon: "ic_fill_arrow_down") {
        
    }
}
