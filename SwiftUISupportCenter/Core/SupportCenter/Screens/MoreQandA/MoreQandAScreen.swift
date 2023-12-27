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
    
    var body: some View {
        HiNavigationView {
            VStack(spacing: 0){
                HiSearchView(searchText: $vm.searchText)
                    .padding(.horizontal, 16)
                    .background(Color.white)
                
                HiDividerLine(hexColor: "#E7E7E7")
                    .padding(.top, 8)
                
                ZStack(alignment: .top) {
                    Color.hiBackground
                        .edgesIgnoringSafeArea(.all)
                    
                    if !vm.listQandA.isEmpty {
                        if vm.isSearching && vm.filteredListQandA.isEmpty {
                            Text("Không có kết quả tìm kiếm")
                                .foregroundColor(Color.hiSecondaryText)
                                .font(.system(size: 16))
                                .padding(.top, 24)
                        }else {
                            ScrollView {
                                VStack{
                                    ForEach(Array(vm.isSearching ? vm.filteredListQandA.enumerated() : vm.listQandA.enumerated()), id: \.element.id) { index, item in
                                        
                                        if (index == (vm.isSearching ? vm.filteredListQandA.count : vm.listQandA.count) - 1) && vm.isSearching {
                                            
                                            SupportQandAItemView(isLastItem: true,qAndAQuestion: item, selectedQuestion: $vm.selectedQandA)
                                        }else {
                                            SupportQandAItemView(qAndAQuestion: item, selectedQuestion: $vm.selectedQandA)
                                        }
                                        
                                    }
                                    
                                    
                                    if (!vm.isSearching && !vm.listQandA.isEmpty) {
                                        Text("Xem thêm")
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.all, 16)
                                .background(Color.white)
                                .cornerRadius(8)
                                .padding(.top, 16)
                              
                                
                                
                            }
                            .padding(.horizontal, 16)
                        }
                       
                    }
                    
                        
                    
                   
                    
                    
                }
                
                
                
            }
            .hiNavigationTitle("Câu hỏi thường gặp")
        }
        .hiLoading(showLoading: vm.isLoading)
            
           
        

    }
}



#Preview {
    MoreQandAScreen()
}
