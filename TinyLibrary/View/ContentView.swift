//
//  ContentView.swift
//  TinyLibrary
//
//  Created by Bora Mert on 8.12.2023.
//

import SwiftUI

struct ContentView: View {
    @State var library = Library()
    @State private var isAddBookPresented = false
    
    var body: some View {
        NavigationView {
            VStack {
                List($library.books) { book in
                    NavigationLink(destination: BookDetailView(library: $library, book: book)) {
                        ListView(book: book)
                    }
                }
            }
            .navigationTitle("Library")
            .navigationBarItems(trailing: addButton)
            .sheet(isPresented: $isAddBookPresented) {
                AddBook(library: $library, isPresented: $isAddBookPresented)
            }
        }
    }
    
    var addButton: some View {
        Button(action: {
            isAddBookPresented.toggle()
        }) {
            Image(systemName: "plus")
        }
    }
}

#Preview {
    ContentView()
}
