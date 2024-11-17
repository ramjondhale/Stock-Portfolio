//
//  HoldingTests.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import XCTest

@testable import Stock_Portfolio

class HoldingTests: XCTestCase {

    func testProfitNLossPositive() {
        let holding = Holding(symbol: "AAPL", quantity: 10.0, averagePrice: 150.0, lastTradedPrice: 150.0, closePrice: 160.0)

        XCTAssertEqual(holding.pnlString, "100.00", "P&L should be 100.00 for this holding")
    }

    func testProfitNLossNegative() {
        let holding = Holding(symbol: "AAPL", quantity: 10.0, averagePrice: 150.0, lastTradedPrice: 160.0, closePrice: 150.0)

        XCTAssertEqual(holding.pnlString, "-100.00", "P&L should be -100.00 for this holding")
    }

    func testProfitNLossZero() {
        let holding = Holding(symbol: "AAPL", quantity: 10.0, averagePrice: 150.0, lastTradedPrice: 150.0, closePrice: 150.0)

        XCTAssertEqual(holding.pnlString, "0.00", "P&L should be 0.00 for this holding")
    }

    func testPnlColorPositive() {
        let holding = Holding(symbol: "AAPL", quantity: 10.0, averagePrice: 150.0, lastTradedPrice: 150.0, closePrice: 160.0)

        // P&L = 100.00, which should be green
        XCTAssertEqual(holding.pnlColor, .green, "P&L color should be green for a positive P&L")
    }

    func testPnlColorNegative() {
        let holding = Holding(symbol: "AAPL", quantity: 10.0, averagePrice: 150.0, lastTradedPrice: 160.0, closePrice: 150.0)

        // P&L = -100.00, which should be red
        XCTAssertEqual(holding.pnlColor, .red, "P&L color should be red for a negative P&L")
    }

    func testPnlColorZero() {
        let holding = Holding(symbol: "AAPL", quantity: 10.0, averagePrice: 150.0, lastTradedPrice: 150.0, closePrice: 150.0)

        // P&L = 0.00, which should be black (neutral)
        XCTAssertEqual(holding.pnlColor, .black, "P&L color should be black for a neutral P&L")
    }
}
