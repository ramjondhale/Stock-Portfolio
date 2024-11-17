//
//  HoldingsResponse.swift
//  Stock_Portfolio
//
//  Created by Ram Jondhale on 16/11/24.
//

struct HoldingsResponse: Decodable {
    let data: HoldingsData
}

struct HoldingsData: Decodable {
    let userHolding: [Holding]
}
