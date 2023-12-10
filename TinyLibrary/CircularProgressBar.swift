//
//  CircularProgressBar.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

import SwiftUI

struct CircularProgressBar: View {
    var percentage: Double
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color.gray.opacity(0.2), style: StrokeStyle(lineWidth: 5, lineCap: .round))
                .overlay(
                    Circle()
                        .trim(from: 0.0, to: CGFloat(min(percentage, 1.0)))
                        .stroke(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.green, Color.blue]),
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            ),
                            style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round)
                        )
                        .rotationEffect(Angle(degrees: -90))
                )
                .rotationEffect(Angle(degrees: 90))
                .frame(width: 50, height: 50)
                .padding(8)
            
            Text("\(Int(percentage * 100))%")
                .font(.caption)
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
    CircularProgressBar(percentage: 100)
}
