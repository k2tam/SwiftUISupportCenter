//
//  SupportCenter.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 13/12/2023.
//

import SwiftUI
import SwiftUIBackports

struct SupportCenterScreen: View {
    @EnvironmentObject var navManager : NavigationTagManager
    
    @Backport.StateObject var vm = SupportCenterViewModel()
    
    
    var body: some View {
        NavigationView {
            HiNavigationView {
                
                ZStack{
                    NavigationLinks
                    
                    //Background layer
                    Color.hiTheme.background
                    
                    //Content Layer
                    
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 24){
                            //MARK: - Create Support Request Block
                            CreateSupportRequestView(supportRequestCategories: vm.createSupportRequestCategories, selectCategoryCallBack: vm.didSelectSupportRequestCategory)
                            
                            
                            //MARK: - Support Request List Block
                            if let supportRequestList = vm.supportRequestList {
                                SupportRequestListView(supportRequestList: supportRequestList.report)
                            }
                            
                            //MARK: - Support Extension Block
                            if let supportExtensionList = vm.supportExtensionList {
                                SupportExtensionsView(supportExtensionsList: supportExtensionList, didSelectSupportExtension: vm.didSelectSupportExtension)
                            }
                            
                            //MARK: - Q&A Support Block
                            if let qAndAQuestionModel = vm.qAndAQuestionModel {
                                SupportQandAView(
                                    qAndAModel: qAndAQuestionModel,
                                    selectedQuestion: $vm.selectedQuestion
                                )
                            }
                            
                            
                            Spacer()

                        }
                    }

                }
                .hiNavigationTitle("Trung tâm hỗ trợ")
                .hiNavigationBackButtonHidden(true)
                .edgesIgnoringSafeArea(.bottom)
            }
        }
    }
        
}

extension SupportCenterScreen {
    
    var NavigationLinks: some View {
        
        Group {
            NavigationLink(
                destination: MoreQandAScreen(),
                tag: eNavTag.toMoreQaAScreen,
                selection: $navManager.navTag) {}
            
            NavigationLink(
                destination: CreateSupportRequestScreen(),
                tag: eNavTag.toSupportRequestScreen,
                selection: $navManager.navTag) {}
            
        }
    }
}



struct SupportCenterScreen_Previews: PreviewProvider {
    static var previews: some View {
        SupportCenterScreen(vm: SupportCenterViewModel())
            .environmentObject(NavigationTagManager.shared)

    }
}



