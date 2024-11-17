//
//  HoldingsServiceProtocol.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 16/11/24.
//

import Foundation

protocol HoldingsServiceProtocol {
    func fetchHoldings() async throws -> [Holding]
}

class HoldingsService: HoldingsServiceProtocol {

    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://35dee773a9ec441e9f38d5fc249406ce.api.mockbin.io/"

    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }

    func fetchHoldings() async throws -> [Holding] {
        guard let url = URL(string: baseURL) else {
            throw URLError(.badURL)
        }

        let holdingsWrapper: HoldingsResponse = try await networkService.fetch(url: url)
        return holdingsWrapper.data.userHolding
    }
}
