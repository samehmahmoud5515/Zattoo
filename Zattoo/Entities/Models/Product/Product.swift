//
//  Product.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    var sku: String?
    var cost: Int?
    var name: String?
    var vatAmount: Int?
    var isTrial: Bool?
    var monthCount: Int?
    var currency: String?
    var length: Int?
    var shopID: String?
    var groups: [String]?
    var units: String?
    var serviceID: Int?
    var active: Bool?
    var productDescription: String?

    enum CodingKeys: String, CodingKey {
        case sku, cost, name
        case vatAmount = "vat_amount"
        case isTrial = "is_trial"
        case monthCount = "month_count"
        case currency, length
        case shopID = "shop_id"
        case groups, units
        case serviceID = "service_id"
        case active
        case productDescription = "description"
    }
}
