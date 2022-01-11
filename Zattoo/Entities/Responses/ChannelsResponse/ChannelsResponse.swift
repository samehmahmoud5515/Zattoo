//
//  ChannelsResponse.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - ChannelsResponse
struct ChannelsResponse: Codable {
    var channels: [Channel]?
    var groups: [Group]?
}
