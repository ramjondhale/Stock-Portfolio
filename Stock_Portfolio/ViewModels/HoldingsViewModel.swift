//
//  HoldingsViewModel.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import Foundation

class HoldingsViewModel {

    // MARK: - Properties

    private(set) var portfolio: Portfolio? = nil
    private(set) var isLoading: Bool = false
    private(set) var errorMessage: String? = nil

    private let holdingsService: HoldingsServiceProtocol

    // MARK: - Initializer

    init(holdingsService: HoldingsServiceProtocol = HoldingsService()) {
        self.holdingsService = holdingsService
    }

    // MARK: - Methods

    func fetchHoldings() async {
        isLoading = true
        errorMessage = nil

        do {
            let holdings = try await holdingsService.fetchHoldings()
            portfolio = Portfolio(holdings: holdings)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Computed properties for the View

    var currentValue: String {
        guard let portfolio = portfolio else { return "N/A" }
        return String(format: "%.2f", portfolio.currentValue)
    }

    var totalInvestment: String {
        guard let portfolio = portfolio else { return "N/A" }
        return String(format: "%.2f", portfolio.totalInvestment)
    }

    var totalPNL: String {
        guard let portfolio = portfolio else { return "N/A" }
        return String(format: "%.2f", portfolio.totalPNL)
    }

    var todaysPNL: String {
        guard let portfolio = portfolio else { return "N/A" }
        return String(format: "%.2f", portfolio.todaysPNL)
    }

    var holdingsCount: Int {
        portfolio?.holdings.count ?? 0
    }

    func holding(at index: Int) -> Holding? {
        guard index >= 0, index < holdingsCount else { return nil }
        return portfolio?.holdings[index]
    }
}
