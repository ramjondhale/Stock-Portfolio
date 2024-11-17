//
//  MockHoldingsService.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import UIKit

class MockHoldingsService: HoldingsServiceProtocol {
    var shouldReturnError = false
    var mockHoldings: [Holding] = []

    func fetchHoldings() async throws -> [Holding] {
        if shouldReturnError {
            throw URLError(.badServerResponse)
        }
        return mockHoldings
    }
}
