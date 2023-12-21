//
//  BookModel.swift
//  TinyLibrary
//
//  Created by Bora Mert on 21.12.2023.
//

import Foundation
import UIKit

struct Books: Decodable {
    var items: [BookItem]
}

struct BookItem: Decodable {
    let id : String
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Decodable {
    let title: String
    let subtitle: String?
    let authors: [String]
    let publishedDate: String
    let pageCount: Int
    let language: String
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case smallThumbnail, thumbnail
    }

    var smallThumbnailURL: URL? {
        return URL(string: smallThumbnail?.httpsURLString ?? "")
    }

    var thumbnailURL: URL? {
        return URL(string: thumbnail?.httpsURLString ?? "")
    }
}

extension String {
    var httpsURLString: String {
        guard let url = URL(string: self) else { return self }
        guard var components = URLComponents(url: url, resolvingAgainstBaseURL: false) else { return self }
        components.scheme = "https"
        return components.url?.absoluteString ?? self
    }
}

