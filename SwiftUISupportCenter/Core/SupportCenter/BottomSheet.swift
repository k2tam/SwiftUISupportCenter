//
//  BottomSheet.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 28/12/2023.
//

import SwiftUI
import SwiftBackports

struct SelectionModel {
    var id: Int
    let title: String
    var isSelected: Bool = false
}

class SupportBottomSheetViewModel: ObservableObject {
    @Published var arrayData: [SelectionModel] = []
    @Published var selectedId: Int = 8
    
    init() {
        self.arrayData = [
            SelectionModel(id: 0, title: "Nâng cấp dịch vụ"),
            SelectionModel(id: 1, title: "Chuyển địa điểm dịch vụ"),
            SelectionModel(id: 2, title: "Khôi phục dịch vụ"),
            SelectionModel(id: 3, title: "Tạm dừng / ngưng dịch vụ"),
            SelectionModel(id: 4, title: "Nâng cấp dịch vụ"),
            SelectionModel(id: 5, title: "Nâng cấp dịch vụ"),
            SelectionModel(id: 6, title: "Nâng cấp dịch vụ"),
            SelectionModel(id: 7, title: "Nâng cấp dịch vụ"),
            SelectionModel(id: 8, title: "Nâng cấp dịch vụ"),
        ]    }
}


struct SupportBottomSheet: View {

    @Backport.StateObject var vm: SupportBottomSheetViewModel
    
    var selectedId: Int = 8
    
    
    let heightOfEachItem: CGFloat
    @State var heightOfScrollContent: CGFloat = 0
    @State var heightOfBottomSheet: CGFloat = 0
    
    
    var showTabBar: Bool
    var showServicesBar: Bool
    
    var servicesBarHeight: CGFloat
    var tabBarHeight: CGFloat
    
    
    var maxHeight: CGFloat = UIScreen.main.bounds.height * 0.5

    //Height probs of child components
    let headerHeight: CGFloat = 88
    let paddingBottom: CGFloat = 40
    

   

    init(heightOfEachItem: CGFloat, showTabBar: Bool = false, showServicesBar: Bool = false){
        
        _vm = Backport.StateObject(wrappedValue: SupportBottomSheetViewModel())
    
        self.heightOfEachItem = heightOfEachItem
        self.showTabBar = showTabBar
        self.showServicesBar = showServicesBar
        
        self.servicesBarHeight = showServicesBar ? 72 : 0
        self.tabBarHeight = showTabBar ? 36 : 0

    }
    
    
    var body: some View{
        ZStack(alignment: .bottom){
            //Dimmed View
            Color.black.opacity(0.5)
               
            //Bottom sheet content
            BottomSheetContent
            
            
        }.edgesIgnoringSafeArea(.all)
            .onAppear(perform: {
                let tempHeightOfBottomSheet = headerHeight + tabBarHeight + servicesBarHeight + CGFloat(vm.arrayData.count) * heightOfEachItem + paddingBottom


                if tempHeightOfBottomSheet >= maxHeight {
                    self.heightOfBottomSheet = maxHeight
                    self.heightOfScrollContent = maxHeight - self.headerHeight - tabBarHeight - servicesBarHeight - self.paddingBottom
                    
                }else {
                    self.heightOfBottomSheet = tempHeightOfBottomSheet
                    self.heightOfScrollContent = CGFloat(vm.arrayData.count) * self.heightOfEachItem
                }
            })
    }
    
    
}


extension SupportBottomSheet {
    private var SheetHeaderView: some View {
        VStack(spacing: 0){
            Color(hex: "#616161")
                .frame(width: 40, height: 4)
                .padding(.vertical, 14)
            
            Text("Tình trạng")
                .font(.system(size: 18, weight: .medium))
                .frame(height: 25)
                .padding(.vertical, 15.5)
            
            HiDividerLine()
                .frame(height: 1)
            
        }
        
    }
    
    private var BottomSheetContent: some View {
        VStack(spacing: 0){
            SheetHeaderView
                .frame(maxWidth: .infinity)
                .frame(height: self.headerHeight)
            
            if showTabBar {
                Color.blue
                    .frame(height: self.tabBarHeight)
            }
            
            if showServicesBar {
                Color.red
                    .frame(height: self.servicesBarHeight)
            }
            
    
            if #available(iOS 14, *) {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0){
                        ScrollViewReader { proxy in
                            ForEach(vm.arrayData, id: \.id){ item in
                                HStack {
                                    Text(item.title)
                                    
                                    Spacer()
                                    
                                    HiImage(string: "ic_radio")
                                        .frame(width: 20, height: 20)
                                }
                                .id(item.id)
                                .frame(height: self.heightOfEachItem)
                                .padding(.horizontal, 16)
                            }
                            .onAppear(perform: {
                                withAnimation(nil){
                                    proxy.scrollTo(vm.selectedId, anchor: .bottom)

                                }
                            })
                        }  
                    }
                }
                .frame(height: self.heightOfScrollContent )
                .padding(.bottom, self.paddingBottom)
            }else {
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0){
                        ForEach(vm.arrayData, id: \.id){ item in
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
        .frame(height:  self.heightOfBottomSheet)
        .background(Color.white)
        .animation(.spring(response: 0.25, dampingFraction: 0.65))
    }
}

struct SupportBottomSheet_Previews: PreviewProvider {
    
    static var previews: some View {
        SupportBottomSheet(heightOfEachItem: 56)
    }
}


