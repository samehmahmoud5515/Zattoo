//
//  Quality.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Quality
struct Quality: Codable {
    var title: String?
    var availability: Availability?
    var logoToken: String?
    var level: Level?
    var drmRequired: Bool?

    enum CodingKeys: String, CodingKey {
        case title, availability
        case logoToken = "logo_token"
        case level
        case drmRequired = "drm_required"
    }
}

extension Quality: Equatable {
    
}
