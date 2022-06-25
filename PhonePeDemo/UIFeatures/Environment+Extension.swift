//
//  Environment+Extension.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI

struct ImageCacheKey: EnvironmentKey {
    static var defaultValue: ImageCache = ImageCacheManager()
}

extension EnvironmentValues {
    var imageCahe: ImageCache {
        get { self[ImageCacheKey.self] }
        set { self[ImageCacheKey.self] = newValue }
    }
}
