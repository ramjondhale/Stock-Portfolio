//
//  Holdings+Formating.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 17/11/24.
//

import UIKit

extension Holding {

    // Calculate the Profit and Loss (P&L)
    var profitNLoss: Double {
        return (closePrice - lastTradedPrice) * Double(quantity)
    }

    // Determine the color for the P&L value
    var pnlColor: UIColor {
        return UIColor.getPNLColor(pnlValue: profitNLoss)
    }

    var pnlString: String {
        return String(format: "%.2f", profitNLoss)
    }
}
