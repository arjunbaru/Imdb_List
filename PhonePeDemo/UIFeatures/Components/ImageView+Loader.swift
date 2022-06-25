//
//  ImageView+Loader.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import Combine
import UIKit

// MARK: Cache Manager

protocol ImageCache {
    subscript (_ key: URL) -> UIImage? { get set }
}

struct ImageCacheManager: ImageCache {
    private let cache = NSCache<NSURL, UIImage>()

    subscript(key: URL) -> UIImage? {
        get {
            cache.object(forKey: key as NSURL)
        }
        set {
            newValue == nil ? cache.removeObject(forKey: key as NSURL) : cache.setObject(newValue!, forKey: key as NSURL)
        }
    }
}

// MARK: ImageLoader

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private let url: URL
    private var manager: ImageCache?
    var cancelable: AnyCancellable?

    init(url: URL, manager: ImageCache? = nil) {
        self.url = url
        self.manager = manager
    }

    func loadImage() {
        if let image = manager?[url] {
            self.image = image
            return
        }

        cancelable = URLSession.shared.dataTaskPublisher(for: url)
            .map({ UIImage(data: $0.data) })
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] image in
                guard let self = self else { return }
                self.manager?[self.url] = image
                self.image = image
            }
    }
}
