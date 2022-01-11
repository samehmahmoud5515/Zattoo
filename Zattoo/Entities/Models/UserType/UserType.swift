//
//  UserType.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - UserType
struct UserType: Codable {
    var biBroadType, biDetailType, biBundleType: String?

    enum CodingKeys: String, CodingKey {
        case biBroadType = "bi_broad_type"
        case biDetailType = "bi_detail_type"
        case biBundleType = "bi_bundle_type"
    }
}
