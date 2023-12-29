//
//  HiSupportBottomSheetContent.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import SwiftUI

struct HiSupportBottomSheetContent: View {
    @Binding var dragOffset: CGSize
    @Binding var vm: HiSupportBottomSheetViewModel
    var showTabBar: Bool
    var showServicesBar: Bool
    let headerHeight: CGFloat
    @Binding var isShowBottomSheet: Bool
    let heightOfBottomSheet: CGFloat
    let dismissHeight: CGFloat
    let tabBarHeight: CGFloat
    
    
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
                            Text(service.title)
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(service.isSelected ?  Color.hiPrimary : Color.hiSecondaryText)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .inset(by: 0.5)
                                        .stroke(service.isSelected ? Color.hiPrimary : Color.hiSecondaryText  , lineWidth: 1)
                                )
                                .onTapGesture(perform: {
                                    
                                })
                        }
                    }
                    .padding(.leading, 16)
                   
                }
                .padding(.vertical, 16)
                .frame(height: self.servicesBarHeight)
            }
            
    
            if #available(iOS 14, *) {
                ScrollView(showsIndicators: false) {
                    
                    ScrollViewReader { proxy in
                        VStack(spacing: 0){
                            ForEach(vm.currentSelections, id: \.id){ item in
                                HStack {
                                    Text(item.title)
                                    
                                    Spacer()
                                    
                                    HiImage(string: item.isSelected ?  "ic_checked_radio" : "ic_radio")
                                        .frame(width: 20, height: 20)
                                }
                                .id(item.id)
                                .frame(height: self.heightOfEachItem)
                                .padding(.horizontal, 16)
                                .onTapGesture(perform: {
                                    self.vm.selectedId = item.id
                                })
                            }
                            
                            .onChange(of: $isShowBottomSheet) { newValue in
                                if newValue {
                                    withAnimation(nil) {
                                        // Scroll to the selected item when the sheet is shown
                                        proxy.scrollTo(vm.selectedId, anchor: .center)
                                        
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
                        ForEach(vm.currentSelections, id: \.id){ item in
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
}

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
//        print("sheet height: \(self.heightOfBottomSheet)")
//        print("dissmiss: \(self.dismissHeight)")
//        print("drag height: \(dragOffset.height)" )
//        print(self.heightOfBottomSheet - self.dragOffset.height)
        
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
}


struct HiSupportBottomSheetContent_Previews: PreviewProvider{
    static var previews: some View {
        HiSupportBottomSheet(isShow: .constant(true), heightOfEachItem: 56, showServicesBar: true)
    }
    

}
