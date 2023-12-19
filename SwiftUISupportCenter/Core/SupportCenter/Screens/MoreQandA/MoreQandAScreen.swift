//
//  MoreQandAView.swift
//  SupportCenter
//
//  Created by k2 tam on 10/11/2023.
//

import SwiftUI
import SwiftUIBackports


struct MoreQandAScreen: View {
    @Backport.StateObject var vm = MoreQandAViewModel()
//    @State var selectedQAItem: QandASupportItem?
    private var SearchBar: some View {
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(Color(hex: "#8CA0C0"))
                    .padding(.leading, 12)
                
                TextField("Tìm kiếm câu hỏi", text: $vm.searchText)
                
                
                Button(action: {
                    vm.searchText = ""
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(Color(hex: "#8CA0C0"))
                        .frame(width: 10, height: 10)
                })
                .padding(.trailing, 13)
                
            }
            .frame(maxWidth: .infinity, maxHeight: 48)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color(hex: "#BDBDBD"), lineWidth: 1)
                    .padding(.vertical, 1)
            )
        
      
    }
    
    var body: some View {
        HiNavigationView {
                VStack(spacing: 0){
                    SearchBar
                        .padding(.horizontal, 16)
                        .background(Color.white)
                    
                    HiDividerLine()
                        .padding(.top, 8)
                    
                    ZStack {
                        Color.hiTheme.background
                            .edgesIgnoringSafeArea(.all)
                        
                        ScrollView {
                            VStack{
                                ForEach(Array(vm.listQandA.enumerated()), id: \.element.id) { index, item in
                                    SupportQandAItemView(qAndAQuestion: item, didSelected: self.manageExpandQAItems)
                                        .onAppear {
                                            if index == vm.listQandA.count - 1 {
                                                vm.fetchListSupportCategory()
                                            }
                                        }
                                }
                                
                                Text("Xem thêm")

                            }
                            .padding(.all, 16)
                            .background(Color.white)
                            .cornerRadius(8)

                        }
                        .frame(maxWidth: .infinity)
                        .padding(.all, 16)

                        
                    }
                    
                   

                }
                .onAppear(perform: {
                    UITableView.appearance().separatorColor = .clear
                    vm.fetchListSupportCategory()
                })
                .hiNavigationTitle("Câu hỏi thường gặp")
        }
      
       
       
    }
    
    
    func manageExpandQAItems(supportQandAItemViewSelected: SupportQandAItemView){
//        if currentSelectedQandA == nil {
//            currentSelectedQandA = supportQandAItemViewSelected
//        }else{
//            /*If current question selected is different from saved selected question then collapse selected question and
//            change selectedQAItem to current question selected
//             */
//            if currentSelectedQandA != supportQandAItemViewSelected {
//                currentSelectedQandA!.isSelected = false
//                currentSelectedQandA = supportQandAItemViewSelected
//            }
//         
//        }
//        
//        withAnimation {
//            currentSelectedQandA?.isSelected.toggle()
//
//        }

    }
}
   


#Preview {
    MoreQandAScreen()
}
