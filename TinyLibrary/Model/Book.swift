//
//  Book.swift
//  TinyLibrary
//
//  Created by Bora Mert on 10.12.2023.
//

import Foundation
import SwiftUI
import UIKit

// Daily reading record structure
struct DailyReading: Codable, Identifiable {
    var id = UUID()
    var date: Date
    var pagesRead: Int
}

struct Book: Identifiable, Decodable, Encodable {
    var id = UUID()
    
    // Using a wrapper type for Image to make it Codable
    struct ImageData: Codable {
        let data: Data?
    }
    
    var imageData: ImageData
    var name: String
    var writer: String
    var pagesRead: Int
    var bookLength: Int
    var dailyReadings: [DailyReading] = [] // Array to store daily reading records
    
    var image: Image {
            if let data = imageData.data, let uiImage = UIImage(data: data) {
                return Image(uiImage: uiImage)
            } else {
                return Image("defaultCover")
            }
        }
    
    var readPercentage: Int {
        return calculatePerc(pagesRead, bookLength)
    }
    
    init(name: String, writer: String, pagesRead: Int, bookLength: Int, selectedImage: UIImage? = UIImage(named:"defaultCover")) {
        self.name = name
        self.writer = writer
        self.pagesRead = pagesRead
        self.bookLength = bookLength
        
        // Convert Image to Data for encoding
        if let uiImage = selectedImage {
            self.imageData = ImageData(data: uiImage.jpegData(compressionQuality: 1.0))
        } else {
            self.imageData = ImageData(data: nil)
        }
    }
    
    func calculatePerc(_ read: Int, _ all: Int) -> Int {
        return all > 0 ? Int(Double(read) / Double(all) * 100.0) : 0
    }
    
    // Add a function to update daily reading
    mutating func addDailyReading(pagesRead: Int, date: Date = Date()) {
        let newReading = DailyReading(date: date, pagesRead: pagesRead)
        dailyReadings.append(newReading)
    }
}
