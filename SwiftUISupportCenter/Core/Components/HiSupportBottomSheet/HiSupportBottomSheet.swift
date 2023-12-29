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

    
    
    @Backport.StateObject var vm: HiSupportBottomSheetViewModel
    
    
    
    let heightOfEachItem: CGFloat
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
            BottomSheetContent
                .frame(height:  self.heightOfBottomSheet)
                .background(Color.white)
                .clipShape(RoundedCorner(radius: 8, corners: [.topLeft, .topRight]))
                .offset(y: self.isShowBottomSheet ? 0 : self.heightOfBottomSheet)
                .animation(.spring(response: 0.25, dampingFraction: 0.65))
                .offset(y: max(dragOffset.height,0))
                .animation(.default.delay(0))
             
               
            
            
            
        }.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                let tempHeightOfBottomSheet = headerHeight + tabBarHeight + servicesBarHeight + CGFloat(vm.currentSelections.count) * heightOfEachItem + paddingBottom

                
                if tempHeightOfBottomSheet >= maxHeight {
                    self.heightOfBottomSheet = maxHeight
                    self.heightOfScrollContent = maxHeight - self.headerHeight - tabBarHeight - servicesBarHeight - self.paddingBottom
                    
                }else {
                    self.heightOfBottomSheet = maxHeight
                    self.heightOfScrollContent = CGFloat(vm.currentSelections.count) * self.heightOfEachItem
                }
                
                self.dismissHeight = self.heightOfBottomSheet * 0.8
            })
    }
    
    
}


extension HiSupportBottomSheet {
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
    
    private func dismiss() {
        self.isShowBottomSheet = false
        dragOffset.height = 0

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
    
    
    
    private var BottomSheetContent: some View {
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
                            
                            .onChange(of: isShowBottomSheet) { newValue in
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



struct HiSupportBottomSheet_Previews: PreviewProvider{
    static var previews: some View {
        HiSupportBottomSheet(isShow: .constant(true), heightOfEachItem: 56, showServicesBar: true)
    }
}
