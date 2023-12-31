//
//  HiSearchView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 22/12/2023.
//

import SwiftUI

struct HiSearchView: View {
    let promptText: String
    @Binding var searchText: String
    
    var body: some View {
        HStack{
            HiImage(string: "ic_search")
                .foregroundColor(Color(hex: "#8CA0C0"))
                .padding(.leading, 12)
              
            
            TextField(promptText, text: $searchText)
                .font(.system(size: 16))
                .foregroundColor(Color(hex: "#888888"))
    
            
            
            Button(action: {
                self.searchText = ""
            }, label: {
                Image(systemName: "xmark")
                    .foregroundColor(Color.hiSecondaryText)
                    .frame(width: 24, height: 24)
            })
            .padding(.trailing, 13)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 48)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(hex: "#E7E7E7"), lineWidth: 1)
                .padding(.vertical, 1)
        )
        .padding(.horizontal, 16)
    }
}


struct HiSearchView_Previews: PreviewProvider {

    static var previews: some View {
        @State  var searchText: String = ""

        HiSearchView(promptText: "Tìm kiếm câu hỏi",searchText: $searchText)
    }
   
}

