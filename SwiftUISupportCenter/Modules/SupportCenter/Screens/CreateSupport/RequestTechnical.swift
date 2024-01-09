//
//  CreateSupportRequestScreen.swift
//  SupportCenter//
//  Created by k2 tam on 14/11/2023.
//

import SwiftUI
import SwiftBackports

struct RequestTechnical: View {
    @Backport.StateObject var vm = CreateSupportRequestViewModel()
    @State private var isShowKeyboard = false
    @State private var isCardShow = false
    @State var navTag: eNavTag?
    
    var body: some View {
        ZStack {
            HiNavigationView {
                ZStack{
                    NavigationLinks
     
                    createSupportContent
                   
                }
                .hiNavigationTitle("Tạo yêu cầu")

                

            }
            .hiFooter1Button(title: "Tiếp tục", action: {
                vm.submitSupportRequest()
            })
            

            GeometryReader { geometry in
                HiBottomSheet(isCardShow: $isCardShow, height: geometry.size.height * 0.6, minHeight: geometry.size.height * 0.3) {
                    SupportRequestBottomSheetContent(isShow: $isCardShow)
                    
                    
                }
            }
            
        }
        .edgesIgnoringSafeArea(.bottom)

    }
  
}

extension RequestTechnical {
    private var NavigationLinks: some View {
        Group {
            NavigationLink(tag: eNavTag.toSupportScheduleScreen, selection: $navTag, destination: {

                SupportScheduleScreen(dateTimeAllowModel: vm.dateTimeAllowModel) { date, time in
                    vm.didGetDateAndTimeSupport(date: date.string(), time: time)
                }
            }){}
        }
    }
    
    
    private var createSupportContent: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 16){
                ContractInfoBlockView(contractNo: "TJBHB7654", fullName: "Nguyễn Thị Hà Trang", address: "123/25, đường Khương Thượng, Đống Đa, Hà Nội")
                    .padding(.top, 16)
                
                //MARK: - State block
                BlockWithActionView(
                    icon: "ic_state",
                    title: "Tình trạng",
                    subTitle: "Tình trạng",
                    selectionText: "Không truy cập được Internet",
                    selectionIcon: "ic_fill_arrow_down"
                )
                {
                    self.isCardShow.toggle()
                }
                
                
                //MARK: - Time schedule block
                BlockWithActionView(
                    icon: "ic_clock",
                    title: "Thời gian đặt lịch hẹn ",
                    subTitle: "Thời gian đặt hẹn",
                    selectionText: "\(self.vm.calendarLabelText)",
                    selectionIcon: "ic_black_calendar"){
                    self.navTag = .toSupportScheduleScreen
                }
                
                ContactInfoView
                
                NoteView
                
                if !isShowKeyboard{
                    Color.clear
                        .frame(minHeight: 144)
                }
            }
            .padding(.horizontal, 16)
        }
        
        
    }
    
    private var NoteView: some View {
        VStack( alignment: .leading, spacing: 16){
            BlockTitle(icon: "ic_note", title: "Ghi chú")

            TextField("Nhập ghi chú", text: $vm.note)
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
        .cornerRadius(8)
    }
    
    private var ContactInfoView: some View {
        VStack(alignment: .leading){
            BlockTitle(icon: "ic_contact", title: "Thông tin liên hệ")
            
            HiDividerLine()
                .padding(.vertical, 16)
            
            ContractFieldInfoView(title: "Người liên hệ", content: "Nguyễn Quỳnh Anh")
            
            HiDividerLine()
                .padding(.vertical, 16)
            
            ContractFieldInfoView(title: "Số điện thoại liên hệ", content: "023523789")
                    
            
        }
        .padding(.all, 16)
        .background(Color.white)
        .cornerRadius(8)
        
        
    }
    
    
    
    
    struct ContractFieldInfoView: View {
        let title: String
        let content: String
        
        var body: some View {
            VStack(alignment: .leading){
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(Color.hiSecondaryText)
                
                Text(content)
                    .font(.system(size: 16, weight: .medium))
            }
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
    RequestTechnical()
}


