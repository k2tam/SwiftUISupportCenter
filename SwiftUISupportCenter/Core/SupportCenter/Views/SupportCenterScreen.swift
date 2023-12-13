//
//  SupportCenter.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI

struct SupportCenterScreen: View {
    var vm = SupportCenterViewModel()
    
    var body: some View {
        NavigationView {
            HiNavigationView {
                ZStack{
                    //Background layer
                    Color.hiTheme.background
                    
                    //Content Layer
                    VStack(spacing: 24){
                        
                        //MARK: - Create Support Request Block
                        CreateSupportRequestView(supportRequestCategories: vm.createSupportRequestCategories, selectCategoryCallBack: vm.didSelectSupportRequestCategory)
                        
                        Spacer()
                        
                        //MARK: - Support Request List Block
                        if let supportRequestList = vm.supportRequestList {
                            SupportRequestListView(/*supportRequestList: supportRequestList*/)

                        }
                        
                        
                        
                        
                    }
                }
                .hiNavigationTitle("Trung tâm hỗ trợ")
                .hiNavigationBackButtonHidden(true)
                
                
            }
        }
    }
}


struct SupportCenterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SupportCenterScreen(vm: SupportCenterViewModel())
    }
}



