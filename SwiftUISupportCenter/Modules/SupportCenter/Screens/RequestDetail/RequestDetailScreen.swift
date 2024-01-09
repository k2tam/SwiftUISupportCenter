//
//  RequestDetailScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 15/12/2023.
//

import SwiftUI

struct RequestDetailScreen: View {
    @State var navTag: eNavTag? = nil
    @State private var isNavToRequestStatusTimeLineScreen: Bool = false
    let supportRequest: SupportRequest
    
    var body: some View {
        HiNavigationView {
            ZStack {
                NavigationLinks
                
                //Content layout
                ScrollView {
                    VStack(spacing: 16){
                        //MARK: - Request status block
                        RequestStatusView {
                            self.navTag = .toRequestStatusTimeLineScreen
                        }
                        
                        //MARK: - Contract info block
                        //TODO: find address
                        ContractInfoView(contractNo: supportRequest.contractNo, address: "")
                        
                        //MARK: - Request info block
                        //TODO: find status
                        RequestInfoView(status: "", time: supportRequest.reportTimeStr, note: supportRequest.note)
                        
                        //MARK: - Contact info block
                        //TODO: Map full name and phoneNumber
                        ContactInfoView(fullName: "Bùi Ngọc Khai Tâm", phoneNumber: "0912321312")
                        
                    }
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                    .padding(.bottom, 112)
                }
            }
            
            
            
            
            .hiNavigationTitle("Chi tiết yêu cầu")
        }
        .hiFooter1Button(buttonType: .secondary, title: "Huỷ yêu cầu", action: {
            print("Huỷ yêu cầu")
        })
    }
}

extension RequestDetailScreen {
    var NavigationLinks: some View {
        Group {
            NavigationLink(
                destination: RequestStatusTimeLineScreen(stepStatusList: supportRequest.stepStatus),
                tag: eNavTag.toRequestStatusTimeLineScreen,
                selection: $navTag) {}
        }
    }
    
    
    struct ContentRow: View {
        let title: String
        let content: String
        let trailingContentIcon: String
        let blockWidth: CGFloat = UIScreen.main.bounds.width - 32
        
        init(title: String, content: String, trailingContentIcon: String = ""){
            self.title = title
            self.content = content
            self.trailingContentIcon = trailingContentIcon
        }
        
        var body: some View {
            HStack(alignment: .top){
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(Color.hiSecondaryText)
                    .frame(maxWidth: blockWidth * 0.3, alignment: .leading)
                
                Spacer()
                
                HStack(spacing: 8){
                    Text(content)
                        .multilineTextAlignment(.trailing)
                        .font(.system(size: 14))
                    
                    
                    if trailingContentIcon != "" {
                        HiImage(string: trailingContentIcon)
                    }
                }
                .frame(maxWidth: blockWidth * 0.68, alignment: .trailing)
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    
    struct ContractInfoView: View {
        let contractNo: String
        let address: String
        
        var body: some View {
            VStack{
                BlockTitle(icon: "ic_contract", title: "Thông tin hợp đồng")
                    .padding(.bottom, 16)
                
                ContentRow(title: "Số hợp đồng", content: contractNo)
                
                HiDividerLine()
                    .padding(.vertical, 8)
                
                ContentRow(title: "Địa chỉ lắp đặt", content: address)
                
                
            }
            .padding(.all, 16)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
    
    struct RequestInfoView: View {
        let status: String
        let time: String
        let note: String
        
        var body: some View {
            VStack{
                BlockTitle(icon: "ic_contract", title: "Thông tin yêu cầu")
                    .padding(.bottom, 16)
                
                ContentRow(title: "Tình trạng", content: status)
                
                HiDividerLine()
                    .padding(.vertical, 8)
                
                ContentRow(title: "Thời gian", content: time, trailingContentIcon: "ic_pencil")
                
                HiDividerLine()
                    .padding(.vertical, 8)
                
                ContentRow(title: "Thông tin liên hệ", content: note)
                
            }
            .padding(.all, 16)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
    
    struct ContactInfoView: View {
        let fullName: String
        let phoneNumber: String
        
        var body: some View {
            VStack{
                BlockTitle(icon: "ic_contact", title: "Thông tin liên hệ")
                    .padding(.bottom, 16)
                
                ContentRow(title: "Họ tên", content: self.fullName)
                
                HiDividerLine()
                    .padding(.vertical, 8)
                
                ContentRow(title: "Điện thoại", content: self.phoneNumber)
                
            }
            .padding(.all, 16)
            .background(Color.white)
            .cornerRadius(8)
        }
    }
}

struct RequestDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        if let supportRequest = dev.supportRequestList?.report[0] {
            RequestDetailScreen(supportRequest: supportRequest)
        }
    }
}


