//
//  Movie+ListViewModel.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI
import Combine

extension Movie.ViewModel {
    /// Enumeration to navigate to all possible places from `ListView`
    enum Navigation {
        case details(Movie)
    }
}

extension Movie {
    class ViewModel: ObservableObject {
        /// Had to import SwiftUI because of `Environment` but we can create something similar `@Dependency`
        /// to avoid such dependency
        @Environment(\.service) private var service
        private var cancellable: AnyCancellable?

        @Published var movies: [Movie]
        @Published var navigation: Navigation?

        init(_ movies: [Movie]) {
            self.movies = movies
        }
    }
}

extension Movie.ViewModel {
    func fetchAllMoview() {
        // TODO: Erorr Handling
        cancellable = service.request(.fetchMovieList)
            .replaceError(with: .init(results: []))
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] response in
                print(response.results)
                self?.movies = response.results
            })
    }

    func navigate(to movie: Movie) {
        self.navigation = .details(movie)
    }
}

