//
//  CircularProgressBar.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

import SwiftUI

struct CircularProgressBar: View {
    var percentage: Double
    var width : CGFloat
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: width/10, lineCap: .round))
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(percentage/100, 1.0)))
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: width/5, lineCap: .round, lineJoin: .round)
                        )
                        .rotationEffect(Angle(degrees: -90))
                )
                .rotationEffect(Angle(degrees: 90))
                .frame(width: width, height: width)
                .padding(8)
            
            Text("\(Int(percentage))%")
                .font(.system(size: width/5 , design: .default))
                .fontWeight(.bold)
        }
        .onAppear {
            withAnimation(.linear(duration: 1.0)) {
                // Add any additional setup code that needs animation
            }
        }
    }
}


#Preview {
    CircularProgressBar(percentage: 10, width: 50)
}
