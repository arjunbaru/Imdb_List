//
//  Movie.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import Foundation

struct MovieResult: Decodable {
    let results: [Movie]
}

struct Movie: Decodable, Identifiable {
    let id: Double
    let title: String
    let overview: String
    private let imagePath: String

    private let imageBaseUrl = "https://image.tmdb.org/t/p/w500"

    var imageUrl: URL? {
        URL(
            string: [imageBaseUrl, imagePath].joined()
        )
    }

    init(
        id: Double,
        title: String,
        overview: String,
        imagePath: String
    ) {
        self.id = id
        self.imagePath = imagePath
        self.overview = overview
        self.title = title
    }
}

extension Movie {
    enum CodingKeys: String, CodingKey {
        case id
        case title = "original_title"
        case overview
        case imagePath = "backdrop_path"
    }
}
