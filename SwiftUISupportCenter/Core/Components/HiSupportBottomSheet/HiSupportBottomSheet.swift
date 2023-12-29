//
//  BottomSheet.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 28/12/2023.
//

import SwiftUI
import SwiftBackports

struct HiSupportBottomSheet: View {
    @Binding var isShowBottomSheet: Bool
    var showTabBar: Bool
    var showServicesBar: Bool
    let heightOfEachItem: CGFloat

    
    
    @Backport.StateObject var vm: HiSupportBottomSheetViewModel
    
    
    
    @State var heightOfScrollContent: CGFloat = 0
    @State var heightOfBottomSheet: CGFloat = 0
    
    @State var dismissHeight: CGFloat = 0
    @State private var dragOffset: CGSize = .zero

    
    
    var servicesBarHeight: CGFloat
    var tabBarHeight: CGFloat
    
    
    var maxHeight: CGFloat = UIScreen.main.bounds.height * 0.4

    //Height probs of child components
    let headerHeight: CGFloat = 88
    let paddingBottom: CGFloat = 40
    

   

    init(isShow: Binding<Bool>,heightOfEachItem: CGFloat, showTabBar: Bool = false, showServicesBar: Bool = false){
        
        _vm = Backport.StateObject(wrappedValue: HiSupportBottomSheetViewModel())
        self._isShowBottomSheet = isShow
        self.heightOfEachItem =  heightOfEachItem
        self.showTabBar = showTabBar
        self.showServicesBar = showServicesBar
        
        self.servicesBarHeight = showServicesBar ? 72 : 0
        self.tabBarHeight = showTabBar ? 36 : 0

    }
    
    
    var body: some View{
        ZStack(alignment: .bottom){
            //Dimmed View
            Color.black.opacity(0.5)
                .opacity(self.isShowBottomSheet ? 1 : 0)
                .animation(.default)
                .onTapGesture(perform: {
                    self.dismiss()
                })
            
            //Bottom sheet content
            HiSupportBottomSheetContent(isShowBottomSheet: self.$isShowBottomSheet, maxHeight: self.maxHeight, heightOfEachItem: self.heightOfEachItem, showServicesBar: self.showServicesBar, showTabBar: self.showTabBar)
             
               
            
            
            
        }
        .edgesIgnoringSafeArea(.all)
        .environmentObject(self.vm)
    }
    
    
    private func dismiss() {
        self.isShowBottomSheet = false

    }
    
    
}


struct HiSupportBottomSheet_Previews: PreviewProvider{
    static var previews: some View {
        HiSupportBottomSheet(isShow: .constant(true), heightOfEachItem: 56, showServicesBar: true)
    }
}
