//
//  HiSupportBottomSheetContent.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import SwiftUI
import SwiftBackports

struct HiSupportBottomSheetContent: View {
    @EnvironmentObject var vm: HiSupportBottomSheetViewModel
    
//    @ObservedObject var vm: HiSupportBottomSheetViewModel
    @Binding var isShowBottomSheet: Bool
    
    
    let heightOfEachItem: CGFloat
    
    @State var heightOfScrollContent: CGFloat = 0
    @State var heightOfBottomSheet: CGFloat = 0
    
    @State var dismissHeight: CGFloat = 0
    @State private var dragOffset: CGSize = .zero
    
    
    
    var servicesBarHeight: CGFloat
    var tabBarHeight: CGFloat
    
    
    var maxHeight: CGFloat
    
    //Height probs of child components
    let headerHeight: CGFloat = 88
    let paddingBottom: CGFloat = 40
    
    var supServices: [BottomSheetSupportService] = []
    var showServicesBar: Bool
    var showTabBar: Bool
    
    
    init(isShowBottomSheet: Binding<Bool>, maxHeight: CGFloat, heightOfEachItem: CGFloat ,showServicesBar: Bool, showTabBar: Bool) {
        self._isShowBottomSheet = isShowBottomSheet
        self.maxHeight = maxHeight
        self.heightOfEachItem = heightOfEachItem
        self.showServicesBar = showServicesBar
        self.showTabBar = showTabBar
        
        self.servicesBarHeight = showServicesBar ? 72 : 0
        self.tabBarHeight = showTabBar ? 36 : 0
        
        
    }
    
    var body: some View {
        VStack(spacing: 0){
            SheetHeaderView
                .frame(maxWidth: .infinity)
                .frame(height: self.headerHeight)
                .gesture(
                    DragGesture()
                        .onChanged({ gesture in
                            dragOffset = gesture.translation
                            
                            
                        })
                        .onEnded({ _ in
                            self.handleDragging()
                        })
                )
            
            
            //MARK: - Tab bar
            if showTabBar {
                Color.blue
                    .frame(height: self.tabBarHeight)
            }
            
            //MARK: - Services bar
            if showServicesBar {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12){
                        ForEach(vm.services) { service in
                            Button {
                                vm.selectedService = service
                            } label: {
                                Text(service.title)
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(service == vm.selectedService ?  Color.hiPrimary : Color.hiSecondaryText)
                                    .padding(.horizontal, 12)
                                    .padding(.vertical, 8)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 8)
                                            .inset(by: 0.5)
                                            .stroke(service == vm.selectedService ? Color.hiPrimary : Color.hiSecondaryText  , lineWidth: 1)
                                    )
                            }
              
                        }
                    }
                    .padding(.leading, 16)
                    
                }
                .padding(.vertical, 16)
                .frame(height: self.servicesBarHeight)
            }
            
            
            //Problems List View
            ProblemsListView(isShowBottomSheet: $isShowBottomSheet, heightOfEachItem: self.heightOfEachItem, heightOfScrollContent: self.heightOfScrollContent, paddingBottom: self.paddingBottom)
                       
        }
        .frame(height:  self.heightOfBottomSheet)
        .background(Color.white)
        .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
        .offset(y: self.isShowBottomSheet ? 0 : self.heightOfBottomSheet)
        .animation(.spring(response: 0.25, dampingFraction: 0.65))
        .offset(y: max(dragOffset.height,0))
        .animation(.default.delay(0))
        .onAppear(perform: {
           setHeightProps()
        })
        
    }
    
}

//Functions
extension HiSupportBottomSheetContent {
    private var SheetHeaderView: some View {
        VStack(spacing: 0){
            
            Color(hex: "#616161")
                .frame(width: 40, height: 4)
                .clipShape(
                    RoundedRectangle(cornerRadius: 100, style: .circular)
                )
                .padding(.vertical, 14)
            
            Text("Tình trạng")
                .font(.system(size: 18, weight: .medium))
                .frame(height: 25)
                .padding(.vertical, 15.5)
            
            HiDividerLine()
                .frame(height: 1)
            
        }
        .background(Color.white)
        
        
    }
    
    private func handleDragging(){
        /*
        //        print("sheet height: \(self.heightOfBottomSheet)")
        //        print("dissmiss: \(self.dismissHeight)")
        //        print("drag height: \(dragOffset.height)" )
        //        print(self.heightOfBottomSheet - self.dragOffset.height)
         */
        
        if ( self.heightOfBottomSheet - self.dragOffset.height <= self.dismissHeight){
            self.dismiss()
        }else if(self.heightOfBottomSheet - self.dragOffset.height  >  self.dismissHeight) {
            //Case drag not meet the min height then reset height for sheet
            dragOffset.height = 0
            
        }
        
        
    }
    
    private func dismiss() {
        self.isShowBottomSheet = false
        dragOffset.height = 0
    }
    
    private func setHeightProps() {
        let tempHeightOfBottomSheet = headerHeight + tabBarHeight + servicesBarHeight + CGFloat(vm.currentProblems.count) * heightOfEachItem + paddingBottom
        
        
        if tempHeightOfBottomSheet >= maxHeight {
            self.heightOfBottomSheet = maxHeight
            self.heightOfScrollContent = maxHeight - self.headerHeight - tabBarHeight - servicesBarHeight - self.paddingBottom
            
        }else {
            self.heightOfBottomSheet = maxHeight
            self.heightOfScrollContent = CGFloat(vm.currentProblems.count) * self.heightOfEachItem
        }
        
        self.dismissHeight = self.heightOfBottomSheet * 0.7
    }
}


struct HiSupportBottomSheetContent_Previews: PreviewProvider{
    static var previews: some View {
        HiSupportBottomSheet(isShow: .constant(true), heightOfEachItem: 56, showServicesBar: true)
    }
    
    
}
