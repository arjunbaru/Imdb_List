//
//  APIClient.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import SwiftUI
import Combine

protocol APIClient {
    func request<Response: Decodable>( _ endpoint: Endpoint<Response>) -> AnyPublisher<Response, Error>
}

// MARK: Endpoint

extension Endpoint {
    /// Enumeration to represent if we have a mock request.
    enum RequetsType {
        case local
        case remote
    }
}

///`Endpoint` to handle all Model related querries
/// We can also extend this to intercept response before mapping.
struct Endpoint<Response: Decodable> {
    let url: URL

    var urlRequest: URLRequest {
        .init(url: url)
    }

    let requestType: RequetsType

    let decode: (Data) throws -> Response
}
