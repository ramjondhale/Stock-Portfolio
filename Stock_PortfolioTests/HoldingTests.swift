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
        let holding = Holding(symbol: "MAHABANK",
                              quantity: 990,
                              averagePrice: 35,
                              lastTradedPrice: 38.05,
                              closePrice: 40)

        XCTAssertEqual(holding.pnlString, "3019.50", "P&L should be 3019.50 for this holding")
    }

    func testProfitNLossNegative() {
        let holding = Holding(symbol: "AIRTEL",
                              quantity: 415,
                              averagePrice: 370.1,
                              lastTradedPrice: 340.75,
                              closePrice: 290)
        XCTAssertEqual(holding.pnlString, "-12180.25", "P&L should be -12180.25 for this holding")
    }

    func testProfitNLossZero() {
        let holding = Holding(symbol: "AAPL", quantity: 10.0, averagePrice: 150.0, lastTradedPrice: 150.0, closePrice: 150.0)

        XCTAssertEqual(holding.pnlString, "0.00", "P&L should be 0.00 for this holding")
    }

    func testPnlColorPositive() {
        let holding = Holding(symbol: "MAHABANK",
                              quantity: 990,
                              averagePrice: 35,
                              lastTradedPrice: 38.05,
                              closePrice: 40)

        // P&L = 3019.50, which should be green
        XCTAssertEqual(holding.pnlColor, .spGreen, "P&L color should be green for a positive P&L")
    }

    func testPnlColorNegative() {
        let holding = Holding(symbol: "AIRTEL",
                              quantity: 415,
                              averagePrice: 370.1,
                              lastTradedPrice: 340.75,
                              closePrice: 290)

        // P&L = -12180.25, which should be red
        XCTAssertEqual(holding.pnlColor, .spRed, "P&L color should be red for a negative P&L")
    }

    func testPnlColorZero() {
        let holding = Holding(symbol: "INFOSYS",
                              quantity: 121,
                              averagePrice: 1305,
                              lastTradedPrice: 1305,
                              closePrice: 1305)

        // P&L = 0.00, which should be black (neutral)
        XCTAssertEqual(holding.pnlColor, .black, "P&L color should be black for a neutral P&L")
    }
}
