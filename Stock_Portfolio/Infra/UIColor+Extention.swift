//
//  UIColor+Extention.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 18/11/24.
//

import UIKit

extension UIColor {

    static var spRed: UIColor {
        return UIColor(red: 199/255, green: 31/255, blue: 33/255, alpha: 1)
    }

    static var spGreen: UIColor {
        return UIColor(red: 45/255, green: 115/255, blue: 53/255, alpha: 1)
    }

    static var spLightGray: UIColor {
        return UIColor(red: 245/255, green: 244/255, blue: 244/255, alpha: 1)
    }

    static func getPNLColor(pnlValue: Double) -> UIColor {
        if pnlValue > 0 {
            return .spGreen
        } else if pnlValue < 0 {
            return .spRed
        } else {
            return .black
        }
    }
}
