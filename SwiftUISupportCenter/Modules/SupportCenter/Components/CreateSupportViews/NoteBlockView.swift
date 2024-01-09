//
//  NoteBlockView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 08/01/2024.
//

import SwiftUI

struct NoteBlockView: View {
    @Binding var noteText: String
    var wasSubmitRequest: Bool
    
    var body: some View {
        VStack( alignment: .leading, spacing: 16){
            BlockTitle(icon: "ic_note", title: "Ghi chú")

            TextField("Nhập ghi chú", text: $noteText)
                .frame(maxWidth: .infinity, minHeight: 80,alignment: .top)
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(hex: "#EBEBEB"), lineWidth: 1))
            
            
            if(wasSubmitRequest && noteText == ""){
                ErrorText(text: "nhập ghi chú")
                
            }
            
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
        
    }
}

//#Preview {
//    NoteBlockView(noteText: <#Binding<String>#>, wasSubmitRequest: <#Bool#>)
//}
