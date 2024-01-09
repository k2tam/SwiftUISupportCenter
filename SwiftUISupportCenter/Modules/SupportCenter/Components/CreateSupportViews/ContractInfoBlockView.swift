//
//  ContractInfoView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 08/01/2024.
//

import SwiftUI

struct ContractInfoBlockView: View {
    let contractNo: String
    let fullName: String
    let address: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            BlockTitle(icon: "ic_contract", title: "Thông tin hợp đồng")
            
            HiDividerLine()
                .padding(.vertical, 16)
            
            
            HStack {
                VStack(alignment: .leading) {
                    Text(contractNo)
                        .font(.system(size: 16))
                        .lineLimit(1)
                    
                        .font(Font.system(size: 14, weight: .medium))
                        .padding(.bottom, 8)
                    
                    Text(fullName)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(Font.system(size: 16))
                        .lineLimit(1)
                        .foregroundColor(Color(hex: "#888888"))
                    
                    Text(address)
                        .fixedSize(horizontal: false, vertical: true)
                        .font(Font.system(size: 16))
                        .lineLimit(1)
                        .foregroundColor(Color(hex: "#888888"))
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .frame(width: 24, height: 24)
            }
            .frame(maxHeight: .infinity)
            
            
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
        .frame(maxWidth: .infinity)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContractInfoBlockView(contractNo: "TJBHB7654", fullName: "Nguyễn Thị Hà Trang", address: "123/25, đường Khương Thượng, Đống Đa, Hà Nội")
            .previewLayout(.sizeThatFits)
    }
}
