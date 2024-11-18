//
//  StocksDescriptionViewTests.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 18/11/24.
//

import XCTest

@testable import Stock_Portfolio

final class StocksDescriptionViewTests: XCTestCase {

    var stocksDescriptionView: StocksDescriptionView!

    override func setUp() {
        super.setUp()
        stocksDescriptionView = StocksDescriptionView(style: .default, reuseIdentifier: StocksDescriptionView.cellIdentifier)
    }

    override func tearDown() {
        stocksDescriptionView = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testCellConfigurationValidHolding() {
        let holding = Holding(symbol: "MAHABANK",
                              quantity: 990,
                              averagePrice: 35,
                              lastTradedPrice: 38.05,
                              closePrice: 40)

        stocksDescriptionView.configure(with: holding)

        XCTAssertEqual(stocksDescriptionView.stockNameLabel.text, "MAHABANK", "Stock name should be correctly set")
        XCTAssertEqual(stocksDescriptionView.stockQuantityLabel.text, "NET QTY: 990.0", "Quantity label should be correctly formatted")
        XCTAssertEqual(stocksDescriptionView.lastTradedPriceLabel.text, "LTP: \u{20B9} 38.05", "LTP label should display correct value")
        XCTAssertNotNil(stocksDescriptionView.profitAndLossLabel.attributedText, "Profit and Loss label should have attributed text")
    }

    func testCellConfigurationPositivePNL() {
        let holding = Holding(symbol: "MAHABANK",
                              quantity: 990,
                              averagePrice: 35,
                              lastTradedPrice: 38.05,
                              closePrice: 40)

        stocksDescriptionView.configure(with: holding)

        let pnlText = stocksDescriptionView.profitAndLossLabel.attributedText?.string
        XCTAssertEqual(pnlText, "P&L: \u{20B9} 3019.50", "P&L label should display correct positive P&L value")
        let color = getPNLColor()
        XCTAssertEqual(color, UIColor.spGreen, "Positive P&L should be displayed in green")
    }

    func testCellConfigurationNegativePNL() {
        let holding = Holding(symbol: "AIRTEL",
                              quantity: 415,
                              averagePrice: 370.1,
                              lastTradedPrice: 340.75,
                              closePrice: 290)

        stocksDescriptionView.configure(with: holding)

        let pnlText = stocksDescriptionView.profitAndLossLabel.attributedText?.string
        XCTAssertEqual(pnlText, "P&L: \u{20B9} -12180.25", "P&L label should display correct negative P&L value")
        let color = getPNLColor()
        XCTAssertEqual(color, UIColor.spRed, "Negative P&L should be displayed in red")
    }

    func testCellConfigurationZeroPNL() {
        let holding = Holding(symbol: "INFOSYS",
                              quantity: 121,
                              averagePrice: 1305,
                              lastTradedPrice: 1305,
                              closePrice: 1305)

        stocksDescriptionView.configure(with: holding)

        let pnlText = stocksDescriptionView.profitAndLossLabel.attributedText?.string
        XCTAssertEqual(pnlText, "P&L: \u{20B9} 0.00", "P&L label should display correct zero P&L value")
        let color = getPNLColor()
        XCTAssertEqual(color, UIColor.black, "Zero P&L should be displayed in black")
    }

    // MARK: - Private Helpers

    private func getPNLColor() -> UIColor {
        let pnlText = stocksDescriptionView.profitAndLossLabel.attributedText?.string
        let attributedText = stocksDescriptionView.profitAndLossLabel.attributedText
        let symbolRange = (pnlText! as NSString).range(of: "\u{20B9}")
        let color = attributedText?.attribute(.foregroundColor, at: symbolRange.location, effectiveRange: nil) as? UIColor
        return color ?? .black
    }
}
