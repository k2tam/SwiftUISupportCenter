//
//  CreateSupportRequestScreen.swift
//  SupportCenter
//
//  Created by k2 tam on 14/11/2023.
//

import SwiftUI
import SwiftBackports

struct CreateSupportRequestScreen: View {
    @Backport.StateObject var vm = CreateSupportRequestViewModel()
    @State private var isShowKeyboard = false
    @State private var isCardShow = false
    @State var navTag: eNavTag?
    
    var body: some View {
        ZStack {
            HiNavigationView {
                ZStack(alignment: .bottom){
                    NavigationLinks
                    
                    Color.hiTheme.background
                    
                    createSupportContent
                    
                    createButton
                    
                }
                .hiNavigationTitle("Tạo yêu cầu hỗ trợ")

    
            }
            
            
            GeometryReader { geometry in
                HiBottomSheet(isCardShow: $isCardShow, height: geometry.size.height * 0.6, minHeight: geometry.size.height * 0.3) {
                    SupportRequestBottomSheetContent(isShow: $isCardShow)
                    
                    
                }
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)

    }
  
}

extension CreateSupportRequestScreen {
    private var NavigationLinks: some View {
        Group {
            NavigationLink(tag: eNavTag.toSupportScheduleScreen, selection: $navTag, destination: {
                SupportScheduleScreen()
            }){}
        }
    }
    
    private var ContractNoView: some View {
        HStack(alignment: .top){
            HiImage(string: "ic_contract")
                .frame(width: 19, height: 24)
                .padding(.trailing, 8)
            
            VStack(alignment: .leading){
                Text("Số hợp đồng")
                    .fontWeight(.medium)
                    .font(Font.system(size: 16))
                    .padding(.bottom, 4)
                
                Text("SGFDN2201")
                    .font(Font.system(size: 14))
                    .padding(.bottom, 8)
                
                //                ScrollView{
                //                    HStack{
                //                        ForEach(vm.contractTags, id: \.self) { tag in
                //                            ContractTagView(text: tag)
                //                        }
                //                    }
                //                }
                //                .padding(.bottom, 16)
                
                Text("138A/28/22 Nguyễn Trãi, Phường 3, Quận 5, TP. Hồ Chí Minh")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(hex: "#888888"))
                
            }
            
            Spacer()
            
            VStack{
                Image(systemName: "chevron.right")
                    .frame(width: 24, height: 24)
            }
            .frame(maxHeight: .infinity, alignment: .center)
            
            
        }
        .padding(.all, 16)
        .background(Color.white)
        .frame(maxWidth: .infinity)
        
    }
    
    private var createButton: some View {
        ZStack{
            Color.white
            
            PrimaryButton(btnText: "Tạo yêu cầu") {
                vm.submitSupportRequest()
            }
            .padding(.init(top: 16, leading: 16, bottom: 32, trailing: 16))
            .frame(maxWidth: .infinity)
            
            
        }
        .frame(maxHeight: 96)
    }
    
    
    private var createSupportContent: some View {
        ScrollView {
            VStack(spacing: 8){
                ContractNoView
                    .padding(.top, 8)
                
                
                BlockWithActionView(icon: "ic_status_grid", title: "Tình trạng", selectionText: "Không truy cập được Internet", systemSelectionIcon: "chevron.down") {
                    self.isCardShow.toggle()
                }
                
                
                BlockWithActionView(icon: "ic_calendar", title: "Thời gian đặt lịch hẹn ", selectionText: "06/04/2022 (10:00 - 11:00)", selectionIcon: "ic_black_calendar"){
                    self.navTag = .toSupportScheduleScreen
                }
                
                ContactInfoView
                
                NoteView
                
                if !isShowKeyboard{
                    Color.clear
                        .frame(minHeight: 144)
                }
            }
        }
        
    }
    
    private var NoteView: some View {
        VStack( alignment: .leading, spacing: 8){
            BlockTitle(icon: "ic_note", title: "Ghi chú")

            TextField("", text: $vm.note)
                .frame(maxWidth: .infinity, minHeight: 80,alignment: .top)
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(hex: "#EBEBEB"), lineWidth: 1))
            
            
            if(vm.wasSubmitRequest && vm.note == ""){
                ErrorText(text: "nhập ghi chú")
                
            }
            
        }
        .padding(.all, 16)
        .background(Color.white)
    }
    
    private var ContactInfoView: some View {
        VStack(alignment: .leading, spacing: 8){
            BlockTitle(icon: "ic_phone_book", title: "Thông tin liên hệ")
            
            ContactTextFieldView(title: "Họ tên", tfText: $vm.fullName, keyboardType: .alphabet, vm: vm)
            ContactTextFieldView(title: "Số điện thoại liên hệ", tfText: $vm.phoneNumber, keyboardType: .phonePad, vm: vm)
            
            
        }
        .padding(.all, 16)
        .background(Color.white)
        
        
    }
    
    
    struct ErrorText: View {
        let text: String
        var body: some View{
            Text("Vui lòng nhập \(text.lowercased())")
                .font(Font.system(size: 14))
                .foregroundColor(.red)
        }
    }
    
    
    struct ContactTextFieldView: View {
        let title: String
        var tfText: Binding<String>
        let keyboardType: UIKeyboardType
        @ObservedObject var vm: CreateSupportRequestViewModel
        
        
        var body: some View {
            VStack(alignment: .leading, spacing: 8){
                Text(title)
                    .font(Font.system(size: 14))
                    .foregroundColor(Color(hex: "#969696"))
                
                HStack{
                    TextField("", text: tfText)
                        .keyboardType(self.keyboardType)
                    
                    
                    
                    
                    if tfText.wrappedValue != "" {
                        Image(systemName: "x.circle.fill")
                            .foregroundColor(Color(hex: "#EBEBEB"))
                            .onTapGesture {
                                self.tfText.wrappedValue = ""
                            }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.vertical, 12)
                .padding(.horizontal, 14)
                .background(RoundedRectangle(cornerRadius: 8).stroke(Color(hex: "#EBEBEB"), lineWidth: 1))
                
                if(vm.wasSubmitRequest && tfText.wrappedValue == ""){
                    ErrorText(text: title)
                    
                }
            }
        }
    }
    
    
}


#Preview {
    CreateSupportRequestScreen()
}


