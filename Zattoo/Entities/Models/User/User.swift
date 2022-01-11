//
//  User.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - User
struct User: Codable {
    var zuyaPermissions: [String]?
    var dateregistered: String?
    var publicID: String?
    var subscriptions: [Subscription]?
    var redeemedTrialServiceIDS: [String]?
    var variantGroup: Int?
    var userType: UserType?
    var products: [Product]?
    var services: [Service]?
    var login: String?
    var youthProtectionRequired: Bool?

    enum CodingKeys: String, CodingKey {
        case zuyaPermissions = "zuya_permissions"
        case dateregistered
        case publicID = "public_id"
        case subscriptions
        case redeemedTrialServiceIDS = "redeemed_trial_service_ids"
        case variantGroup = "variant_group"
        case userType = "user_type"
        case products, services, login
        case youthProtectionRequired = "youth_protection_required"
    }
}
