//
//  Movie+Endpoint.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import Foundation

extension Endpoint where Response == MovieResult {
    static var fetchMovieList: Self {
        let path = Bundle.main.path(forResource: "imdb_mock", ofType: "json")
        return .init(url: URL(fileURLWithPath: path!), requestType: .local) { data in
            try JSONDecoder().decode(MovieResult.self, from: data)
        }
    }
}
