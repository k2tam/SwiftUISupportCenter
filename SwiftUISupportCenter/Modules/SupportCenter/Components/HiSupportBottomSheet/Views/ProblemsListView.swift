//
//  ProblemsListView.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import SwiftUI

struct ProblemsListView: View {
    @EnvironmentObject var vm: HiSupportBottomSheetViewModel
    @Binding var isShowBottomSheet: Bool
    let heightOfEachItem: CGFloat
    let heightOfScrollContent: CGFloat
    let paddingBottom: CGFloat
    
    var body: some View {
        if #available(iOS 14, *)
        {
            ScrollView(showsIndicators: false) {
                ScrollViewReader { proxy in
                    VStack(spacing: 0){
                        ForEach(vm.currentProblems){ item in
                            HStack {
                                Text(item.title)
                                
                                Spacer()
                                
                                HiImage(string: item == vm.selectedProblem ?  "ic_checked_radio" : "ic_radio")
                                    .frame(width: 20, height: 20)
                            }
                            .id(item.id)
                            .frame(height: self.heightOfEachItem)
                            .padding(.horizontal, 16)
                            .onTapGesture(perform: {
                                self.vm.selectedProblem = item
                            })
                        }
                        .onChange(of: isShowBottomSheet) { newValue in
                            if newValue {
                                withAnimation(nil) {
                                    // Scroll to the selected item when the sheet is shown
                                    proxy.scrollTo(vm.selectedProblem?.id  , anchor: .center)
                                    
                                }
                            }
                        }
                        
                    }
                }
            }
            .frame(height: self.heightOfScrollContent )
            .padding(.bottom, self.paddingBottom)
            
        }else {
            ScrollView(showsIndicators: false) {
                VStack(spacing: 0){
                    ForEach(vm.currentProblems){ item in
                        HStack {
                            Text(item.title)
                            
                            Spacer()
                            
                            HiImage(string: "ic_radio")
                                .frame(width: 20, height: 20)
                        }
                        .frame(height: self.heightOfEachItem)
                        .padding(.horizontal, 16)
                    }
                }
            }
            .frame(height: self.heightOfScrollContent )
            .padding(.bottom, self.paddingBottom)
        }
    }
}

struct ProblemsListView_Previews: PreviewProvider{
    static var previews: some View {
        HiSupportBottomSheet(isShow: .constant(true), heightOfEachItem: 56, showServicesBar: true)
    }
    
    
}
