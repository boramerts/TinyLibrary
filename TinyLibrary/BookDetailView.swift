//
//  BookDetailView.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

import SwiftUI

struct BookDetailView: View {
    @Binding var library: Library
    @Binding var book: Book
    @State private var pagesReadStepperValue: Double = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            VStack {
                HStack(alignment: .top) {
                    book.image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 150)
                        .cornerRadius(8)
                        .padding(.trailing, 20)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text(book.name)
                            .font(.title)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(book.writer)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .fixedSize(horizontal: false, vertical: true)
                        HStack{
                            Spacer()
                            
                            CircularProgressBar(percentage: Double(book.readPercentage) / 100.0)
                                .padding(.trailing, 20)
                        }
                    }
                    
                    Spacer()
                }
                
            }
            
            Divider()
            
            Text("Number of Pages: \(book.bookLength)")
                .font(.title2)
                .foregroundColor(.gray)
            
            Stepper("Pages Read: \(Int(pagesReadStepperValue))", value: $pagesReadStepperValue, in: 0...Double(book.bookLength))
                .padding(.vertical, 10)
                .onChange(of: pagesReadStepperValue) {
                    book.pagesRead = Int(pagesReadStepperValue)
                }
            
            Spacer()
            
            Button(action: {
                if let index = library.books.firstIndex(where: { $0.id == book.id }) {
                    library.deleteBook(index)
                }
            }) {
                Text("Delete Book")
                    .padding()
                    .foregroundColor(.white)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.red))
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 20)
            .padding(.bottom, 40)
        }
        .padding()
    }
}


#Preview {
    BookDetailView(library: .constant(Library()), book: .constant(Book(name: "Book Name Long For Demo", writer: "Long Writer Name to Demo", pagesRead: 1, bookLength: 1)))
}
