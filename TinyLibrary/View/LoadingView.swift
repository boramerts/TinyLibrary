//
//  LoadingView.swift
//  TinyLibrary
//
//  Created by Bora Mert on 21.12.2023.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4).edgesIgnoringSafeArea(.all)

            HStack{
                Text("Loading...")
                    .font(.system(size: 20 , weight: .bold, design: .rounded))
                    .padding()
                Spacer()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .padding()
            }
            .frame(width: 200, height: 50)
            .background(Color.secondary.colorInvert())
            .foregroundColor(Color.primary)
            .cornerRadius(10)
        }
    }
}

#Preview {
    LoadingView()
}
