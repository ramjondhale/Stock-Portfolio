//
//  Holdings+Formating.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import UIKit

extension Holding {

    private var totalInvestment: Double {
        return averagePrice * Double(quantity)
    }

    private var currentValue: Double {
        return lastTradedPrice * Double(quantity)
    }

    var profitNLoss: Double {
        return currentValue - totalInvestment
    }

    var pnlColor: UIColor {
        return UIColor.getPNLColor(pnlValue: profitNLoss)
    }

    var pnlString: String {
        return String(format: "%.2f", profitNLoss)
    }
}
