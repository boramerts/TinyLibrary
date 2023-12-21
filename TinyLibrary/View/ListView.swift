//
//  ListView.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

import SwiftUI

struct ListView: View {
    @Binding var book : Book
    
    var body: some View {
        HStack(alignment: .top){
            book.image
                .resizable()
                .scaledToFit()
                .frame(width: 70)
                .padding(.trailing)
            VStack(alignment: .leading){
                Text(book.name)
                    .font(.headline)
                Text(book.writer)
                    .font(.caption)
            }
            Spacer()
            CircularProgressBar(percentage: Double(book.readPercentage), width: 40)
        }
        .padding(10)
        .id(book.id)
    }
}


#Preview {
    ListView(book: .constant(Book(name: "Name", writer: "Writer", pagesRead: 1, bookLength: 10)))
}
