//
//  Service.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Service
struct Service: Codable {
    var possibleCids: [String]?
    var blockedServiceIDS: [Int]?
    var serviceDescription: String?
    var shopURL, image, tncURL: String?
    var isAdult: Bool?
    var subservices: [Int]?
    var sortOrder: Int?
    var active: Bool?
    var type: String?
    var id: Int?
    var blockingServiceIDS: [Int]?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case possibleCids = "possible_cids"
        case blockedServiceIDS = "blocked_service_ids"
        case serviceDescription = "description"
        case shopURL = "shop_url"
        case image
        case tncURL = "tnc_url"
        case isAdult = "is_adult"
        case subservices
        case sortOrder = "sort_order"
        case active, type, id
        case blockingServiceIDS = "blocking_service_ids"
        case name
    }
}
