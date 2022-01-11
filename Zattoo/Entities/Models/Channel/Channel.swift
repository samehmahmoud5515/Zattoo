//
//  Channel.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Channel
struct Channel: Codable {
    var groupIDS: [Int]?
    var isRadio: Bool?
    var urlCid, title, cid: String?
    var number: Int?
    var recording: Bool?
    var qualities: [Quality]?
    var aliasCids: [String]?

    enum CodingKeys: String, CodingKey {
        case groupIDS = "group_ids"
        case isRadio = "is_radio"
        case urlCid = "url_cid"
        case title, cid, number, recording, qualities
        case aliasCids = "alias_cids"
    }
}
