//
//  SelectContract.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 27/12/2023.
//

import SwiftUI


struct SelectContract: View {
    @State var searchText: String = ""
    var body: some View {
        HiNavigationView {
            VStack{
                HiSearchView(promptText: "Tìm kiếm hợp đồng",searchText: $searchText)
                
                ZStack(alignment: .top){
                    Color.hiBackground
                    
                    ScrollView {
                        VStack(spacing: 8) {
                            ContractView()
                            
                            ContractView()

                        }
                        .padding(.top, 8)

                    }
                   
              
                }
            }
                .hiNavigationTitle("Chọn hợp đồng")
                .hiToolBar {
                    HStack{
                        Button {
                            
                        } label: {
                            HiImage(string: "ic_gear")
                                .frame(width: 24, height: 24)
                        }

                    }
                }
        }
    }
}

struct ContractView: View {
    var body: some View {
        VStack {
            HStack(alignment: .top){
                VStack(alignment: .leading, spacing: 4){
                    Text("Nhà ba mẹ")
                        .font(.system(size: 16, weight: .medium))
                    
                    
                    Text("SGFDN2201")
                        .font(.system(size: 16))

                }

                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HiImage(string: "ic_checked_radio")
                        .frame(width: 20, height: 20)
                })
                
              
                
                
            }
            .padding(.bottom, 8)
            
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    TextWithContainerView(text: "Chính chủ", textColor: Color.hiPrimary, containerColor: Color.hiBlueContainer)
                    
                    TextWithContainerView(text: "Combo Internet", textColor: Color.hiPrimary, containerColor: Color.hiBlueContainer)
                    
                   
                }
            }
            .frame(height: 21)
            
            HiDividerLine()
                .padding(.vertical, 16)
            
            Text("130 Đường số 40 (Tầng 1, VP PNC), P.Tân Phong, Quận 7, TPHCM")
                .font(.system(size: 14))
            
        }
        .padding(.all, 16)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(8)
        .padding(.horizontal, 16)
        

    }
}

#Preview {
    SelectContract()
}
