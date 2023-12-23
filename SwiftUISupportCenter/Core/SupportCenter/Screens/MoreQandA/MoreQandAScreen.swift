//
//  MoreQandAView.swift
//  SupportCenter
//
//  Created by k2 tam on 10/11/2023.
//

//import SwiftUI
//import SwiftUIBackports
//
//
//struct MoreQandAScreen: View {
//    @Backport.StateObject var vm = MoreQandAViewModel()
//   
//    var body: some View {
//        HiNavigationView {
//                VStack(spacing: 0){
//                    HiSearchView(searchText: vm.searchText)
//                        .padding(.horizontal, 16)
//                        .background(Color.white)
//                    
//                    HiDividerLine()
//                        .padding(.top, 8)
//                    
//                    ZStack {
//                        Color.hiTheme.background
//                            .edgesIgnoringSafeArea(.all)
//                        
//                        ScrollView {
//                            VStack{
//                                ForEach(Array(vm.listQandA.enumerated()), id: \.element.id) { index, item in
//                                    SupportQandAItemView( qAndAQuestion: item, didSelected: self.manageExpandQAItems)
//                                       
//                                }
//                                
//                                Text("Xem thêm")
//
//                            }
//                            .padding(.all, 16)
//                            .background(Color.white)
//                            .cornerRadius(8)
//
//                        }
//                        .frame(maxWidth: .infinity)
//                        .padding(.all, 16)
//
//                        
//                    }
//                    
//                   
//
//                }
//                .onAppear(perform: {
//                    UITableView.appearance().separatorColor = .clear
//                })
//                .hiNavigationTitle("Câu hỏi thường gặp")
//        }
//      
//       
//       
//    }
//    
//    
//    func manageExpandQAItems(supportQandAItemViewSelected: SupportQandAItemView){
//        if vm.currentSelectedQandA == nil {
//            vm.currentSelectedQandA = supportQandAItemViewSelected
//        }else{
//            /*If current question selected is different from saved selected question then collapse selected question and
//            change selectedQAItem to current question selected
//             */
//            if vm.currentSelectedQandA! != supportQandAItemViewSelected {
//                vm.currentSelectedQandA!.isSelected = false
//                vm.currentSelectedQandA! = supportQandAItemViewSelected
//                
//                withAnimation {
//                    vm.currentSelectedQandA?.isSelected.toggle()
//                }
//            }else{
//                withAnimation {
//                    vm.currentSelectedQandA?.isSelected = false
//                    vm.currentSelectedQandA = nil
//                }
//            }
//
//        }
//        
//       
//        
//      
//
//    }
//}
//   
//
//
//#Preview {
//    MoreQandAScreen()
//}
