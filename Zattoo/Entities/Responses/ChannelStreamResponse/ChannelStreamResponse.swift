//
//  ChannelStreamResponse.swift
//  Zattoo
//
//  Created by SAMEH on 02/01/2022.
//

import Foundation

// MARK: - ChannelStreamResponse
struct ChannelStreamResponse: Codable {
    var tracking: Tracking?
    var success: Bool?
    var stream: ChannelStream?
    var registerTimeshift, csid, minConnectivity, unregisteredTimeshift: String?

    enum CodingKeys: String, CodingKey {
        case tracking, success, stream
        case registerTimeshift = "register_timeshift"
        case csid
        case minConnectivity = "min_connectivity"
        case unregisteredTimeshift = "unregistered_timeshift"
    }
}
