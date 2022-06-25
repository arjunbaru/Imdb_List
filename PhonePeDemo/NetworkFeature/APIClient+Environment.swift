//
//  APIClient+Environment.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI

/// Key to inject dependency to views
/// Just like `Live` we can also have `Noop` or `Stub` versions when
/// we want to mock this service
struct NetworkKey: EnvironmentKey {
    static var defaultValue: APIClient = .live
}

extension EnvironmentValues {
    var service: APIClient {
        get { self[NetworkKey.self] }
        set {self[NetworkKey.self] = newValue }
    }
}

