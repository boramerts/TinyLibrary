//
//  pagesReadEditor.swift
//  TinyLibrary
//
//  Created by Bora Mert on 22.12.2023.
//

import SwiftUI

struct pagesReadEditor: View {
    @Binding var library: Library
    @Binding var book: Book
    @Binding var localPagesRead: Int

    var body: some View {
        VStack(alignment: .center){
            Text("Pages Read").font(.title2).fontWeight(.bold).padding(.bottom,10)
            Text("\(Int(localPagesRead))/\(book.bookLength)").font(.title)
            Spacer()
            HStack{
                Button(action: {
                    updatePagesRead(-1)
                }) {
                    Image(systemName: "minus")
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .padding(.leading,20)
                
                Spacer()
                
                Button(action: {
                    updatePagesRead(1)
                }) {
                    Image(systemName: "plus")
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.white)
                        .background(Color.blue)
                        .clipShape(Circle())
                }
                .padding(.trailing,20)
            }
            .padding(.bottom, 20)
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10).fill(.black).stroke(.secondary, lineWidth: 3))
    }

    private func updatePagesRead(_ change: Int) {
        if localPagesRead > 0 || localPagesRead < book.bookLength {
            localPagesRead += change
        }

        if let index = library.books.firstIndex(where: { $0.id == book.id }) {
            // Update the total pages read
            library.books[index].pagesRead = Int(localPagesRead)
            book.pagesRead = Int(localPagesRead)

            // Add or update the daily reading record
            let today = Date()
            if let dailyIndex = library.books[index].dailyReadings.firstIndex(where: { Calendar.current.isDate($0.date, inSameDayAs: today) }) {
                library.books[index].dailyReadings[dailyIndex].pagesRead += Int(change)
            } else {
                let newDailyReading = DailyReading(date: today, pagesRead: Int(change))
                library.books[index].dailyReadings.append(newDailyReading)
            }
            
            library.saveBooks()
        }
    }
}

#Preview {
    pagesReadEditor(library: .constant(Library()), book: .constant(Book(name: "Book Name Long For Demo", writer: "Long Writer Name to Demo", pagesRead: 1, bookLength: 100)),localPagesRead: .constant(1))
}
