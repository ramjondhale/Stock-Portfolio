//
//  NetworkService.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 16/11/24.
//

import UIKit

protocol NetworkServiceProtocol {
    func fetch<T: Decodable>(url: URL) async throws -> T
}

class NetworkService: NetworkServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetch<T: Decodable>(url: URL) async throws -> T {
        let (data, response) = try await session.data(for: URLRequest(url: url))

        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode(T.self, from: data)
    }
}
