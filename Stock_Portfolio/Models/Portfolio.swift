//
//  Portfolio.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import Foundation

struct Portfolio {

    let holdings: [Holding]

    var currentValue: Double {
        holdings.reduce(0) { $0 + ($1.lastTradedPrice * $1.quantity) }
    }

    var totalInvestment: Double {
        holdings.reduce(0) { $0 + ($1.averagePrice * $1.quantity) }
    }

    var totalPNL: Double {
        currentValue - totalInvestment
    }

    var todaysPNL: Double {
        holdings.reduce(0) { $0 + (($1.closePrice - $1.lastTradedPrice) * $1.quantity) }
    }
}
