//
//  Session.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Session
struct Session: Codable {
    var logoBaseURL: String?
    var vodProviders: [String]?
    var startPagePublicID: String?
    var privacyPolicy: String?
    var adSkipTime: Int?
    var imageBaseURL: String?
    var maxSignupBirthdate, aliasedCountryCode, powerGuideHash: String?
    var recordingEligible, adsAllowed, loggedin: Bool?
    var vodPagePublicID: String?
    var active: Bool?
    var generalTerms: String?
    var blockSize: Int?
    var broadcastPagePublicID: String?
    var currentTime: String?
    var lineupHash, language: String?
    var trackingUrls: [String]?
    var channelPagePublicID, recordingsPagePublicID: String?
    var minConnectivity, ppid: String?
    var html5Streaming: Bool?

    enum CodingKeys: String, CodingKey {
        case logoBaseURL = "logo_base_url"
        case vodProviders = "vod_providers"
        case startPagePublicID = "start_page_public_id"
        case privacyPolicy = "privacy_policy"
        case adSkipTime = "ad_skip_time"
        case imageBaseURL = "image_base_url"
        case maxSignupBirthdate = "max_signup_birthdate"
        case aliasedCountryCode = "aliased_country_code"
        case powerGuideHash = "power_guide_hash"
        case recordingEligible = "recording_eligible"
        case adsAllowed = "ads_allowed"
        case loggedin
        case vodPagePublicID = "vod_page_public_id"
        case active
        case generalTerms = "general_terms"
        case blockSize = "block_size"
        case broadcastPagePublicID = "broadcast_page_public_id"
        case currentTime = "current_time"
        case lineupHash = "lineup_hash"
        case language
        case trackingUrls = "tracking_urls"
        case channelPagePublicID = "channel_page_public_id"
        case recordingsPagePublicID = "recordings_page_public_id"
        case minConnectivity = "min_connectivity"
        case ppid
        case html5Streaming = "html5_streaming"
    }
}
