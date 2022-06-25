//
//  APIClient+Live.swift
//  PhonePeDemo
//
//  Created by Arjun Baru on 25/06/22.
//

import Combine
import SwiftUI

/// Live version of `APIClient`
struct LiveApiClient: APIClient {
    fileprivate static let shared = Self()

    func request<Response>(_ endpoint: Endpoint<Response>) -> AnyPublisher<Response, Error> where Response : Decodable {
        switch endpoint.requestType {
            case .remote:
               return URLSession.shared.dataTaskPublisher(for: endpoint.url)
                    .map(\.data)
                    .tryMap { data in
                        do {
                            return try endpoint.decode(data)
                        } catch {
                            print(error)
                            throw error
                        }
                    }
                    .receive(on: DispatchQueue.main)
                    .eraseToAnyPublisher()
            case .local:
                return Future<Data, Error> { promise in
                    do {
                        let data = try Data(contentsOf: endpoint.url)
                        promise(.success(data))
                    } catch {
                        promise(.failure(error))
                    }
                }
                .tryMap({ data in
                    print(data)
                    do {
                       return try endpoint.decode(data)
                    } catch {
                        print(error)
                        throw error
                    }
                })
                .receive(on: DispatchQueue.main)
                .eraseToAnyPublisher()
        }
    }
}

extension APIClient where Self == LiveApiClient {
    static var live: Self {
        .shared
    }
}
