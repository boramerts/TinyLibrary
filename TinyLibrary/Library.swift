//
//  Library.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

import Foundation

@Observable class Library {
    var books : [Book] = [
        Book(name: "Welcome to TinyLibrary!", writer: "Press the + Button to add new books!", pagesRead: 1, bookLength: 1)
    ]
    
    init() {
        loadBooks()
    }
    
    func addBook(_ book: Book) {
        books.insert(book, at: 0)
        saveBooks()
    }
    
    func deleteBook(_ index: Int) {
        books.remove(at: index)
        saveBooks()
    }
    
    private func saveBooks() {
        do {
            let encodedData = try JSONEncoder().encode(books)
            UserDefaults.standard.set(encodedData, forKey: "library_books")
        } catch {
            print("Error encoding books: \(error)")
        }
    }
    
    private func loadBooks() {
        if let data = UserDefaults.standard.data(forKey: "library_books") {
            do {
                books = try JSONDecoder().decode([Book].self, from: data)
            } catch {
                print("Error decoding books: \(error)")
            }
        }
    }
}

