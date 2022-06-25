//
//  ImageView.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI

struct ImageView<PlaceHolder: View, Content: View>: View {
    let placeholder: () -> PlaceHolder
    let contentView: (UIImage) -> Content
    @StateObject private var loader: ImageLoader

    init(
        url: URL,
        @ViewBuilder placeHolder: @escaping () -> PlaceHolder,
        @ViewBuilder contentView: @escaping (UIImage) -> Content
    ) {
        self.contentView = contentView
        self.placeholder = placeHolder
        self._loader = .init(wrappedValue: .init(url: url, manager: Environment(\.imageCahe).wrappedValue))
    }

    var body: some View {
        content
            .onAppear {
                loader.loadImage()
            }
    }

    @ViewBuilder
    var content: some View {
        if let image = loader.image {
            contentView(image)
        } else {
            placeholder()
        }
    }
}
