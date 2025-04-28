//
//  AirtableResponse.swift
//  Kebuke Ordering App
//
//  Created by 林上閔 on 4/28/25.
//

import Foundation

struct AirtableResponse: Codable {
    let records: [OrderRecord]
}

struct OrderRecord: Codable {
    let id: String
    let fields: OrderFields
}

struct OrderFields: Codable {
    let DrinkName: String?
    let Size: String?
    let Sweetness: String?
    let Ice: String?
    let CustomerName: String?
}
