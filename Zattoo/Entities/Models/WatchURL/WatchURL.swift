//
//  WatchURL.swift
//  Zattoo
//
//  Created by SAMEH on 02/01/2022.
//

import Foundation

// MARK: - WatchURL
struct WatchURL: Codable {
    var url: String?
    var maxrate: Int?
    var audioChannel: String?

    enum CodingKeys: String, CodingKey {
        case url, maxrate
        case audioChannel = "audio_channel"
    }
}
