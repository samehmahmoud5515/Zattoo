//
//  ChannelStream.swift
//  Zattoo
//
//  Created by SAMEH on 02/01/2022.
//

import Foundation

// MARK: - Stream
struct ChannelStream: Codable {
    var url: String?
    var watchUrls: [WatchURL]?
    var quality: String?
    var replaySeekingAllowed: Bool?

    enum CodingKeys: String, CodingKey {
        case url
        case watchUrls = "watch_urls"
        case quality
        case replaySeekingAllowed = "replay_seeking_allowed"
    }
}
