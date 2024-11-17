//
//  APIServiceTests.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 16/11/24.
//

import XCTest

@testable import Stock_Portfolio

class HoldingsServiceTests: XCTestCase {

    func testFetchHoldingsSuccess() async throws {
        let json = """
        {
            "data": {
                "userHolding": [
                    {
                        "symbol": "MAHABANK",
                        "quantity": 990,
                        "ltp": 38.05,
                        "avgPrice": 35,
                        "close": 40
                    },
                    {
                        "symbol": "ICICI",
                        "quantity": 100,
                        "ltp": 118.25,
                        "avgPrice": 110,
                        "close": 105
                    }
                ]
            }
        }
        """.data(using: .utf8)!

        let mockService = MockNetworkService()
        mockService.mockData = json

        let apiService = HoldingsService(networkService: mockService)
        let holdings = try await apiService.fetchHoldings()

        XCTAssertEqual(holdings.count, 2)
        XCTAssertEqual(holdings[0].symbol, "MAHABANK")
        XCTAssertEqual(holdings[1].symbol, "ICICI")
    }

    func testFetchHoldingsNetworkError() async throws {
        let mockService = MockNetworkService()
        mockService.shouldReturnError = true

        let apiService = HoldingsService(networkService: mockService)

        do {
            _ = try await apiService.fetchHoldings()
            XCTFail("Expected failure but got success")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil")
        }
    }

    func testFetchHoldingsInvalidJSON() async throws {
        let json = """
        {
            "invalidKey": []
        }
        """.data(using: .utf8)!

        let mockService = MockNetworkService()
        mockService.mockData = json

        let apiService = HoldingsService(networkService: mockService)

        do {
            _ = try await apiService.fetchHoldings()
            XCTFail("Expected failure but got success")
        } catch {
            XCTAssertNotNil(error, "Error should not be nil")
        }
    }
}
