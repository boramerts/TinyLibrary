//
//  Quotes.swift
//  TinyLibrary
//
//  Created by Bora Mert on 23.12.2023.
//

import SwiftUI

struct Quotes: View {
    var body: some View {
        VStack{
            HStack{
                Text("Quotes").font(.title2).fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                Spacer()
                Image(systemName: "chevron.left")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10)
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10)
                    .padding(.leading,5)
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 15)
                    .padding(.leading,10)
            }.padding(.top,20).padding(.leading,20).padding(.trailing,20)
            Spacer()
            Text("\"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam\"").italic().padding().padding(.bottom,20)
        }
        .background(RoundedRectangle(cornerRadius: 10).fill(.secondary).stroke(.secondary, lineWidth: 3))
        .frame(height: 200)
    }
}

#Preview {
    Quotes()
}
