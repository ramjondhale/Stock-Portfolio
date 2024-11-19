//
//  HoldingsViewModelTests.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import XCTest

@testable import Stock_Portfolio

final class HoldingsViewModelTests: XCTestCase {

    var viewModel: HoldingsViewModel!
    var mockService: MockHoldingsService!

    override func setUp() {
        super.setUp()
        mockService = MockHoldingsService()
        viewModel = HoldingsViewModel(holdingsService: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testFetchHoldingsSuccess() async {
        mockService.mockHoldings = [
            Holding(symbol: "MAHABANK", quantity: 990, averagePrice: 35, lastTradedPrice: 38.05, closePrice: 40),
            Holding(symbol: "ICICI", quantity: 100, averagePrice: 110, lastTradedPrice: 118.25, closePrice: 105),
            Holding(symbol: "SBI", quantity: 150, averagePrice: 501, lastTradedPrice: 550.05, closePrice: 590)
        ]

        await viewModel.fetchHoldings()

        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch completes")
        XCTAssertNil(viewModel.errorMessage, "errorMessage should be nil on success")
        XCTAssertNotNil(viewModel.portfolio, "Portfolio should not be nil")
        XCTAssertEqual(viewModel.holdingsCount, 3, "Portfolio should contain 3 holdings")
    }

    func testFetchHoldingsError() async {
        mockService.shouldReturnError = true

        await viewModel.fetchHoldings()

        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch completes")
        XCTAssertNotNil(viewModel.errorMessage, "errorMessage should not be nil on error")
        XCTAssertNil(viewModel.portfolio, "Portfolio should be nil on error")
    }

    func testFetchHoldingsEmptyResponse() async {
        mockService.mockHoldings = []

        await viewModel.fetchHoldings()

        XCTAssertFalse(viewModel.isLoading, "isLoading should be false after fetch completes")
        XCTAssertNil(viewModel.errorMessage, "errorMessage should be nil on success")
        XCTAssertNotNil(viewModel.portfolio, "Portfolio should not be nil even if it's empty")
        XCTAssertEqual(viewModel.portfolio?.holdings.count, 0, "Portfolio should contain 0 holdings")
        XCTAssertEqual(viewModel.currentValue, "0.00", "Current value should be 0 for empty portfolio")
    }

    func testComputedProperties() async {
        mockService.mockHoldings = [
            Holding(symbol: "TATA STEEL", quantity: 200, averagePrice: 110.65, lastTradedPrice: 137, closePrice: 100.05),
            Holding(symbol: "INFOSYS", quantity: 121, averagePrice: 1245.45, lastTradedPrice: 1305, closePrice: 1103.85)
        ]

        await viewModel.fetchHoldings()

        XCTAssertEqual(viewModel.currentValue, "185305.00", "Current value should be calculated correctly")
        XCTAssertEqual(viewModel.totalInvestment, "172829.45", "Total investment should be calculated correctly")
        XCTAssertEqual(viewModel.totalPNL, "12475.55", "Total P&L should be calculated correctly")
        XCTAssertEqual(viewModel.todaysPNL, "-31729.15", "Today's P&L should be calculated correctly")
    }
}
