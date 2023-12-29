//
//  HiBottomSheetView.swift
//  SupportCenter
//
//  Created by k2 tam on 15/11/2023.
//

import SwiftUI

struct HiBottomSheet<Content: View>: View {
    @Binding private var isCardShow: Bool
    private var content: Content
    private var height: CGFloat
    private let minHeight: CGFloat
    private let cornerRadius: CGFloat
    @State private var dragOffset: CGSize = .zero
    
    private var indicator: some View {
        Color(hex: "#3C3C43", alpha: 0.3)
            .clipShape(.capsule)
            .frame(
                width: 36,
                height: 5
            )
            .padding(.top, 5)
    }
    
    init(isCardShow: Binding<Bool>,
         height: CGFloat,minHeight: CGFloat,
         cornerRadius: CGFloat = 8,
         @ViewBuilder content: () -> Content)
    {
        _isCardShow = isCardShow
        self.height = height
        self.minHeight = height * 0.55
        self.cornerRadius = cornerRadius
        self.content = content()
        
    }
    
    var body: some View{
        ZStack{
            //Dimmed View
            Rectangle()
                .foregroundColor(Color.gray.opacity(0.5))
                .opacity(isCardShow ? 1 : 0)
                .animation(.default)
                .onTapGesture {
                    self.dismiss()
                }
            
            VStack{
                Spacer()
                
                
                //Content Area
                VStack{
                    indicator
                    self.content
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: height)
                .padding(.bottom, 10)
                .background(Color.white)
                
//                .cornerRadius(self.cornerRadius, corners: [.topLeft,.topRight])
                .offset(y: isCardShow ? 0 : height)
                .animation(.spring(response: 0.25, dampingFraction: 0.65))
                .offset(y: max(dragOffset.height,0))
                .animation(.default.delay(0))
                .gesture(
                    DragGesture()
                        .onChanged({ gesture in
                            dragOffset = gesture.translation
                        
                            
                        })
                        .onEnded({ _ in
                            self.handleDragAction()
                        })
                )
               
                
                
            }
        }
        .edgesIgnoringSafeArea(.all)
        
    }
    
    
    private func handleDragAction(){
        if (dragOffset.height >= minHeight){
            self.dismiss()
        }else if(dragOffset.height < minHeight) {
            //Case drag not meet the min height then reset height for sheet
            dragOffset.height = 0
            
        }
        
        
    }
    
     func dismiss() {
        isCardShow.toggle()
        
        dragOffset.height = 0
    }
    
    
}

