//
//  Movie+ListView.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI

extension Movie {
    struct ListView: View {
        @ObservedObject var viewModel: ViewModel

        var body: some View {
            content
                .navigationTitle("IMDB")
                .navigationLink($viewModel.navigation, destination: { item in
                    switch item {
                        case let .details(movie):
                            /// Had to append Movie prefix becase of preview
                            Movie.DetailsView(model: movie)
                    }
                })
                .onAppear {
                    viewModel.fetchAllMoview()
                }
        }

        var content: some View {
            List {
                ForEach(viewModel.movies, content: row)
            }
            .listStyle(.plain)
        }

        func row(_ item: Movie) -> some View {
            HStack(alignment: .top) {
                imageView(url: item.imageUrl)
                VStack(alignment: .leading, spacing: 8) {
                    Text(item.title)
                        .font(.title3)
                    Text(item.overview)
                        .font(.callout)
                }
                .padding()
            }
            .frame(height: 100)
            .onTapGesture {
                viewModel.navigate(to: item)
            }
        }

        @ViewBuilder
        func imageView(url: URL?) -> some View {
            if let url = url {
                ImageView(url: url) {
                    ProgressView()
                        .frame(width: 60, height: 100)
                } contentView: { image in
                    Image(uiImage: image)
                        .resizable()
                        .cornerRadius(6)
                        .frame(width: 60, height: 100)
                }
            }
        }
    }
}

// MARK: Preview

struct Movie_ListView_Previews: PreviewProvider {
    static var previews: some View {
        Movie.ListView(viewModel: .init([]))
    }
}
