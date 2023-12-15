//
//  SupportRequesttBottomSheetContent.swift
//  SupportCenter
//
//  Created by k2 tam on 15/11/2023.
//

import SwiftUI

struct SupportRequestBottomSheetContent: View {
    var categories: [eContractService] = [.tvInternet,.camera]
    var listSupportStatus: [eSupportStatus] = [.cantSeeCameraOnApp, .badResolution ,.cantReplay, .errorDevice, .maintain]
    
    
    @Binding var isShow: Bool
    @State var categorySelected: eContractService? = nil
    @State var statusSelected: eSupportStatus? = nil
    
  
    
    var body: some View {
        VStack{
            HStack{
                Text("Tình trạng")
                    .padding(.top, 8)
                    .font(Font.system(size: 18,weight: .medium))
                
                Spacer()
                
                Button {
                    self.isShow = false
                } label: {
                    Image(systemName: "star.fill")
                }
                .frame(width: 30, height: 30)

            }
            .padding(EdgeInsets(top: 7, leading: 16, bottom: 24, trailing: 14))
            
            ScrollView(.horizontal){
                HStack{
                    ForEach(Array(categories.enumerated()), id: \.element){index, item in
                        
                        Button(action: {
                            self.categorySelected = item
                        }, label: {
                            if categorySelected == nil {
                                if index == 0 {
                                    CategorySupportView(text: item.serviceText(), isSelected: true)
                                }else {
                                    CategorySupportView(text: item.serviceText())

                                }
                            }else {
                                if item == categorySelected {
                                    CategorySupportView(text: item.serviceText(), isSelected: true)

                                }else {
                                    CategorySupportView(text: item.serviceText())

                                }
                            }
                        })
    
                    }
                }
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 24, trailing: 0))
            
            HiDividerLine()
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    ForEach(Array(listSupportStatus.enumerated()), id: \.element){index, status in
                        
                        
                        Button(action: {
                            statusSelected = status
                        }, label: {
                            VStack{
                                if status == statusSelected {
                                    StatusItem(text: status.statusText(), isSelected: true)

                                }else {
                                    StatusItem(text: status.statusText())
                                }
                                
                                
                                if index != listSupportStatus.count - 1 {
                                    HiDividerLine()
                                }

                            }
                        })
                       
                    }
                }
                .padding(.bottom, 100)

            }
            .padding(.top, 6)
            .padding(.horizontal, 28)

        }
        
    }
}


extension SupportRequestBottomSheetContent{
    struct CategorySupportView: View {
        let text: String
        var isSelected: Bool = false
        var backgroundColor = Color(hex: "#4A6187", alpha: 0.08)
        var activeBackgroundColor = Color(hex: "#3C4E6D")
        
        var body: some View {
            Text(text)
                .font(Font.system(size: 14))
                .padding(.vertical, 4)
                .padding(.horizontal, 16)
                .frame(maxHeight: 30)
                .background(isSelected ? activeBackgroundColor: backgroundColor)
                .foregroundColor(isSelected ? .white : .black)
                .clipShape(.capsule)
            
        }
    }
    
    
    struct StatusItem: View {
        let text: String
        var isSelected: Bool = false
        
        var body: some View {
            HStack{
                Text(text)
                    .font(Font.system(size: 14))
                    .multilineTextAlignment(.leading)
                    .fixedSize(horizontal: false, vertical: true)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "star.fill")
                    .frame(width: 24, height: 24)
               
                .padding(.leading, 37)
            }
            .padding(.vertical, 16)
           
        }
    }
}

//#Preview {
//    SupportRequestBottomSheetContent()
//}
