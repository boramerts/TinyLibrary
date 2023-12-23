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
    @State var localPagesRead: Int
    
    init(library: Binding<Library>, book: Binding<Book>) {
        self._library = library
        self._book = book
        // Initialize the Stepper value with the current pages read of the book
        self._localPagesRead = State(initialValue: book.wrappedValue.pagesRead)
    }
    
    var body: some View {
        VStack(alignment: .center){
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
                            .font(.headline)
                            .fontWeight(.bold)
                            .fixedSize(horizontal: false, vertical: true)
                        Text(book.writer)
                            .font(.subheadline)
                            .foregroundColor(.white)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 30)
                        HStack{
                            Spacer()
                            
                            CircularProgressBar(percentage: Double(book.readPercentage), width: 50)
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(.secondary).stroke(.secondary, lineWidth: 3))
            }
            HStack{
                pagesReadEditor(library: $library, book: $book, localPagesRead: $localPagesRead).frame(maxWidth: .infinity, maxHeight: .infinity)
                Quotes().frame(maxWidth: .infinity, maxHeight: .infinity)
            }.frame(maxHeight: 200)
            HStack{
                readingGraph(book: $book).frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            HStack{
                Quotes()
            }
        }.padding()
    }
}


#Preview {
    BookDetailView(library: .constant(Library()), book: .constant(Book(name: "Book Name Long For Demo", writer: "Long Writer Name to Demo", pagesRead: 1, bookLength: 100)))
}
