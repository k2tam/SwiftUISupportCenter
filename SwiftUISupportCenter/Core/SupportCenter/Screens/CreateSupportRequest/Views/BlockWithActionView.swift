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
    let selectionText: String
    let selectionIcon: String?
    let systemSelectionIcon: String?
    let action: (() -> Void)
    
    
    init(icon: String, title: String, selectionText: String, selectionIcon: String? = nil, systemSelectionIcon: String? = nil, action: @escaping () -> Void) {
        self.icon = icon
        self.title = title
        self.selectionText = selectionText
        self.selectionIcon = selectionIcon
        self.systemSelectionIcon = systemSelectionIcon
        self.action = action
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            BlockTitle(icon: self.icon, title: self.title)
            
            Button {
                action()
            } label: {
                HStack{
                    Text(selectionText)
                        .font(Font.system(size: 14))
                    Spacer()
                    
                    if let selectionIcon = selectionIcon {
                        HiImage(string: selectionIcon)
                    }
                    
                    if systemSelectionIcon != nil {
                        Image(systemName: "chevron.down")
                            .frame(width: 24, height: 24)
                    }
                    
                    
                    
                }
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(
                    Color(hex: "#4A6187", alpha: 0.08)
                        .cornerRadius(8)
                )
                .foregroundColor(Color.black)
                
                
                
            }
            
        }
        .padding(.all, 16)
        .background(Color.white)
        
        
        
        
        
    }
}


