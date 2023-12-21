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
    @State private var isBarcodeScannerPresented = false
    @State private var isLoading = false
    
    @State private var foundBooks: Books?
    
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
                    // Select Image
                    Button(action: {
                        isSheetPresented.toggle()
                        isImagePickerPresented.toggle()
                    }) {
                        HStack {
                            Text("Select Image")
                            Spacer()
                            Image(systemName: "photo.badge.plus.fill")
                        }
                    }
                    // Scan From Camera
                    Button(action: {
                        isSheetPresented.toggle()
                        isScannerPresented.toggle()
                    }) {
                        HStack {
                            Text("Scan from Camera")
                            Spacer()
                            Image(systemName: "camera")
                        }
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
                    // Scan Barcode
                    Button(action: {
                        isSheetPresented.toggle()
                        isBarcodeScannerPresented.toggle()
                    }) {
                        HStack {
                            Text("Scan Barcode to Add Book")
                            Spacer()
                            Image(systemName: "barcode")
                        }
                    }
                    
                    // Add Book
                    Button(action: {
                        if let numberOfPages = Int(numberOfPagesString) {
                            let newBook = Book(
                                name: newBookName,
                                writer: newBookWriter,
                                pagesRead: 0,
                                bookLength: numberOfPages >= 0 ? numberOfPages : 1,
                                selectedImage: selectedImage
                            )
                            library.addBook(newBook)
                            isPresented = false
                        }
                    }) {
                        HStack {
                            Text("Add Book").fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            Spacer()
                            Image(systemName: "plus")
                        }
                    }.tint(.green)
                }
            }
            .navigationTitle("Add New Book")
            .overlay(isLoading ? LoadingView() : nil)
            .navigationBarItems(trailing: Button("Cancel") {
                isPresented = false
            })
            .sheet(isPresented: $isImagePickerPresented) {
                ImagePicker(selectedImage: $selectedImage)
            }
            .sheet(isPresented: $isScannerPresented) {
                DocumentScannerView(scannedImage: $selectedImage)
            }
            .sheet(isPresented: $isBarcodeScannerPresented) {
                BarcodeScannerView(foundBooks: $foundBooks, onScanComplete: { books in
                    isLoading = true
                    self.updateFields(books: books) {
                        isLoading = false
                    }
                })
            }
        }
    }
    
    func updateFields(books: Books?, completion: @escaping () -> Void) {
        print("Getting book data...")
        guard let book = books?.items.first else {
            print("No book found returning...")
            return
        }
        print("Got book")
        newBookName = book.volumeInfo.title
        print("Got name")
        newBookWriter = book.volumeInfo.authors.first ?? ""
        print("Got writer")
        let pages = book.volumeInfo.pageCount
        print("Got page count")
        numberOfPagesString = String(pages)
        
        if let url = book.volumeInfo.imageLinks?.thumbnailURL{
            downloadImage(from: url) { downloadedImage in
                self.selectedImage = downloadedImage
                print("Got book cover")
                completion()
            }
        }
    }
    
    func downloadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil, let image = UIImage(data: data) else {
                completion(nil)
                return
            }

            DispatchQueue.main.async {
                completion(image)
            }
        }.resume()
    }
}


#Preview {
    AddBook(library: .constant(Library()), isPresented: .constant(true))
}
