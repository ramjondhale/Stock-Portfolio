//
//  BottomSheetViewTests.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 18/11/24.
//

import XCTest

@testable import Stock_Portfolio

final class BottomSheetViewTests: XCTestCase {

    var bottomSheetView: PortfolioSummaryBottomSheetView!

    override func setUp() {
        super.setUp()
        bottomSheetView = PortfolioSummaryBottomSheetView(frame: .zero)
    }

    override func tearDown() {
        bottomSheetView = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testConfigureLabels() {
        let currentValue = "5000.00"
        let totalInvestment = "4500.00"
        let todaysPNL = "500.00"
        let totalPNL = "2000.00"

        bottomSheetView.configure(currentValue: currentValue, totalInvestment: totalInvestment, todaysPNL: todaysPNL, totalPNL: totalPNL)

        XCTAssertEqual(bottomSheetView.currentAmountLabel.text, "\u{20B9} \(currentValue)", "Current value label should be correctly configured")
        XCTAssertEqual(bottomSheetView.totalInvestmentAmountLabel.text, "\u{20B9} \(totalInvestment)", "Total investment label should be correctly configured")
        XCTAssertEqual(bottomSheetView.pnlAmountLabel.text, "\u{20B9} \(todaysPNL)", "Today's P&L label should be correctly configured")
        XCTAssertEqual(bottomSheetView.totalPNLAmountLabel.text, "\u{20B9} \(totalPNL)", "Total P&L label should be correctly configured")
    }

    func testPNLColors() {
        let positivePNL = "500.00"
        let negativePNL = "-300.00"
        let zeroPNL = "0.00"

        bottomSheetView.configure(currentValue: "0", totalInvestment: "0", todaysPNL: positivePNL, totalPNL: negativePNL)

        XCTAssertEqual(bottomSheetView.pnlAmountLabel.textColor, UIColor.spGreen, "Positive P&L should be green")
        XCTAssertEqual(bottomSheetView.totalPNLAmountLabel.textColor, UIColor.spRed, "Negative P&L should be red")

        bottomSheetView.configure(currentValue: "0", totalInvestment: "0", todaysPNL: zeroPNL, totalPNL: zeroPNL)
        XCTAssertEqual(bottomSheetView.pnlAmountLabel.textColor, UIColor.black, "Zero P&L should be black")
        XCTAssertEqual(bottomSheetView.totalPNLAmountLabel.textColor, UIColor.black, "Zero P&L should be black")
    }

    func testHandlePnlStackTap() {
        bottomSheetView.handlePnlStackTap()

        XCTAssertTrue(bottomSheetView.containerStackView.isHidden, "ContainerStackView should be hidden")
        XCTAssertTrue(bottomSheetView.dividerView.isHidden, "DividerView should be hidden")

        // Tap again to toggle back
        bottomSheetView.handlePnlStackTap()
        XCTAssertFalse(bottomSheetView.containerStackView.isHidden, "ContainerStackView should be visible")
        XCTAssertFalse(bottomSheetView.dividerView.isHidden, "DividerView should be visible")
    }
}
