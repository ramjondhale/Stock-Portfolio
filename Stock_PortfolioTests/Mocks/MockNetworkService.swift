//
//  MockNetworkService.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 16/11/24.
//

import UIKit

@testable import Stock_Portfolio

class MockNetworkService: NetworkServiceProtocol {
    var shouldReturnError = false
    var mockData: Data?

    func fetch<T: Decodable>(url: URL) async throws -> T {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        guard let data = mockData else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode(T.self, from: data)
    }
}
