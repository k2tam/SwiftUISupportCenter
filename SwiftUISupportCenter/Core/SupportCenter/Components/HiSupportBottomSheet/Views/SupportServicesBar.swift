//
//  SupportServicesBar.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 29/12/2023.
//

import SwiftUI
import SwiftUIBackports

struct SupportServicesBar: View {
    @EnvironmentObject private var vm: HiSupportBottomSheetViewModel
    let servicesBarHeight: CGFloat
    @Binding var isShowBottomSheet: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            if #available(iOS 14, *) {
                ScrollViewReader(content: { proxy in
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
                            .id(service.id)
              
                        }
                        
                        
                    }
                    .padding(.leading, 16)
                    .backport.onChange(of: self.isShowBottomSheet) { _ in
                        proxy.scrollTo(vm.selectedService?.id)
                    }
                })
                
            }else {
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
            
         

            
        }

        .padding(.vertical, 16)
        .frame(height: self.servicesBarHeight)
    }
}


struct SupportServicesBar_Previews: PreviewProvider{
    static var previews: some View {
        HiSupportBottomSheet(isShow: .constant(true), heightOfEachItem: 56, showServicesBar: true)
    }
}
