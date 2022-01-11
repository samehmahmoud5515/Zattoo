//
//  Subscription.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Subscription
struct Subscription: Codable {
    var sku: String?
    var autorenewalFailed, mayAutorenew, autorenewing, externalAutorenewing: Bool?
    var shopID: String?
    var expiration: String?
    var serviceID: Int?
    var beginning: String?
    var id: Int?

    enum CodingKeys: String, CodingKey {
        case sku
        case autorenewalFailed = "autorenewal_failed"
        case mayAutorenew = "may_autorenew"
        case autorenewing
        case externalAutorenewing = "external_autorenewing"
        case shopID = "shop_id"
        case expiration
        case serviceID = "service_id"
        case beginning, id
    }
}
