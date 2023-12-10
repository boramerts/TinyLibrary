//
//  AddBook.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

// AddBookView.swift
import SwiftUI
import VisionKit

struct AddBook: View {
    @Binding var library: Library
    @Binding var isPresented: Bool
    
    @State private var newBookName = ""
    @State private var newBookWriter = ""
    @State private var numberOfPagesString = "1"
    @State private var selectedImage: UIImage? = nil
    @State private var isSheetPresented = false
    @State private var isImagePickerPresented = false
    @State private var isScannerPresented = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Book Details")) {
                    TextField("Book Name", text: $newBookName)
                    TextField("Writer", text: $newBookWriter)
                }
                
                Section(header: Text("Book Length")) {
                    TextField("Number of Pages", text: $numberOfPagesString)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("Book Cover")) {
                    Button("Select Image") {
                        isSheetPresented.toggle()
                        isImagePickerPresented.toggle()
                    }
                    Button("Scan from Camera") {
                        isSheetPresented.toggle()
                        isScannerPresented.toggle()
                    }
                    Image(uiImage: selectedImage ?? UIImage(named: "defaultCover")!)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .onTapGesture {
                            isImagePickerPresented.toggle()
                        }
                }
                
                Section {
                    Button("Add Book") {
                        // Add your logic for adding a new book here
                        if let numberOfPages = Int(numberOfPagesString) {
                            let newBook = Book(
                                name: newBookName,
                                writer: newBookWriter,
                                pagesRead: 0,
                                bookLength: numberOfPages,
                                selectedImage: selectedImage
                            )
                            library.addBook(newBook)
                            isPresented = false
                        }
                    }
                }
            }
            .navigationTitle("Add New Book")
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .sheet(isPresented: $isScannerPresented) {
                DocumentScannerView(scannedImage: $selectedImage)
            }
        }
    }
}


#Preview {
    AddBook(library: .constant(Library()), isPresented: .constant(true))
}
