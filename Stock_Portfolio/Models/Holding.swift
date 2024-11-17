//
//  Holding.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 16/11/24.
//

import Foundation

struct Holding: Decodable {
    let symbol: String
    let quantity: Double
    let averagePrice: Double
    let lastTradedPrice: Double
    let closePrice: Double

    enum CodingKeys: String, CodingKey {
        case symbol
        case quantity
        case averagePrice = "avgPrice"
        case lastTradedPrice = "ltp"
        case closePrice = "close"
    }
}
