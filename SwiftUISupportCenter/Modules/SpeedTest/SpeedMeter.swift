//
//  SpeedMeter.swift
//  SwiftUISupportCenter
//
//  Created by k2 tam on 09/01/2024.
//

import SwiftUI

struct Meter: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let pi = CGFloat.pi
        path.addArc(
            center: center,
            radius: 100,
            startAngle: .radians(2 * pi / 3) ,
            endAngle: .radians(pi / 3),
            clockwise: false
        )
        return path
    }
}


struct SpeedMeter: View {
    
    var blueGradColors = [
        Color(red: 3/255, green: 48/255, blue: 207/255),
        Color(red: 27/255, green: 118/255, blue: 255/255),
        Color(red: 53/255, green: 182/255, blue: 255/255),
  ]
    

    
    var body: some View {
        ZStack{
            ZStack(alignment: .bottom){
                Meter()
                    .stroke(style: StrokeStyle(lineWidth: 20,lineCap: .round))
                    .foregroundColor(Color.blue)
                
                Circle()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color.hiSecondaryText)
                    .opacity(0.1)
                
                
                ZStack {
                    Circle()
                        .frame(width: 16, height: 16)
                        .foregroundColor(Color(hex: "#3D3D3D"))
                    
                    
                    Color(hex: "#3D3D3D")
                        .frame(width: 4, height: 56)
                }
                .rotationEffect(.init(degrees: 35))
               
                
                
                
                
            }
        }
    }
}

#Preview {
    SpeedMeter()
}
