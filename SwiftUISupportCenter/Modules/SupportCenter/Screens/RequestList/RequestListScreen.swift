//
//  RequestListScreen.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 26/12/2023.
//

import SwiftUI
import HiThemes

enum RequestTab {
    case progressing
    case completed
}

struct RequestListScreen: View {
    @State private var selectedTab: RequestTab = .progressing
    
    var body: some View {
        HiNavigationView {
            VStack(spacing: 0){
                TabNavigationView
                
                ZStack {
                    Color.hiBackground
                    
                    ScrollView {
                        VStack{
                            RequestTicketView()
                            
                        }
                        .padding(.top, 16)
                        .padding(.horizontal, 16)
                    }
                    
                    
                }
                
                
                
            }
            .hiNavigationTitle("Yêu cầu")
            .hiToolBar {
                HStack(spacing: 16){
                    Button(action: {
                        
                    }, label: {
                        HiImage(string: "ic_phone")
                    })
                    
                    Button(action: {
                        
                    }, label: {
                        HiImage(string: "ic_filter")
                    })
                }
            }
            
        }
    }
}





extension RequestListScreen {
    private var TabNavigationView: some View {
        HStack(spacing: 0){
            
            Button(action: {
                selectedTab = .progressing
            }, label: {
                ZStack(alignment: .bottom){
                    Text( "Đang xử lý")
                        .foregroundColor(selectedTab == .progressing ? .black : Color.hiSecondaryText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Rectangle()
                        .fill(selectedTab == .progressing ? Color.hiPrimary : .clear)
                        .frame(height: 1)
                }
                .foregroundColor(.black)
                
            })
            
            Button(action: {
                selectedTab = .completed
            }, label: {
                ZStack(alignment: .bottom){
                    Text("Hoàn tất")
                        .foregroundColor(selectedTab == .completed ? .black : Color.hiSecondaryText)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                    Rectangle()
                        .fill(selectedTab == .completed ? Color.hiPrimary : .clear)
                        .frame(height: 1)
                }
                .foregroundColor(.black)
            })
            
            
            
        }
        .frame(height: 56)
    }
}

#Preview {
    RequestListScreen()
}
