//
//  LoginSession.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Session
struct LoginSession: Codable {
    var startPagePublicID, publicID: String?
    var recommendationCategories: [String]?
    var personalRecommendations, adsAllowed: Bool?
    var currentTime: String?
    var blockSize: Int?
    var broadcastPagePublicID: String?
    var recallEligible: Bool?
    var recallSeconds, adSkipTime: Int?
    var sseURL: String?
    var seriesRecordingEligible: Bool?
    var channelPagePublicID: String?
    var abTestGroups, ppid, recordingsPagePublicID: String?
    var recordingSubscribable: Bool?
    var logoBaseURL: String?
    var vodEligible: Bool?
    var privacyPolicy: String?
    var vodProviders: [String]?
    var imageBaseURL: String?
    var aliasedCountryCode, powerGuideHash, maxSignupBirthdate: String?
    var recordingSpaceSubscribable: Bool?
    var lineupHash: String?
    var maxPlaylistSize: Int?
    var user: User?
    var recordingEligible, active: Bool?
    var generalTerms: String?
    var localRecordingEligible: Bool?
    var privacySettings: [String]?
    var loggedin: Bool?
    var language: String?
    var trackingUrls: [String]?
    var recommenderSystem: String?
    var recallStartTime: String?
    var vodPagePublicID: String?
    var minConnectivity, serviceRegionCountry: String?
    var html5Streaming: Bool?

    enum CodingKeys: String, CodingKey {
        case startPagePublicID = "start_page_public_id"
        case publicID = "public_id"
        case recommendationCategories = "recommendation_categories"
        case personalRecommendations = "personal_recommendations"
        case adsAllowed = "ads_allowed"
        case currentTime = "current_time"
        case blockSize = "block_size"
        case broadcastPagePublicID = "broadcast_page_public_id"
        case recallEligible = "recall_eligible"
        case recallSeconds = "recall_seconds"
        case adSkipTime = "ad_skip_time"
        case sseURL = "sse_url"
        case seriesRecordingEligible = "series_recording_eligible"
        case channelPagePublicID = "channel_page_public_id"
        case abTestGroups = "ab_test_groups"
        case ppid
        case recordingsPagePublicID = "recordings_page_public_id"
        case recordingSubscribable = "recording_subscribable"
        case logoBaseURL = "logo_base_url"
        case vodEligible = "vod_eligible"
        case privacyPolicy = "privacy_policy"
        case vodProviders = "vod_providers"
        case imageBaseURL = "image_base_url"
        case aliasedCountryCode = "aliased_country_code"
        case powerGuideHash = "power_guide_hash"
        case maxSignupBirthdate = "max_signup_birthdate"
        case recordingSpaceSubscribable = "recording_space_subscribable"
        case lineupHash = "lineup_hash"
        case maxPlaylistSize = "max_playlist_size"
        case user
        case recordingEligible = "recording_eligible"
        case active
        case generalTerms = "general_terms"
        case localRecordingEligible = "local_recording_eligible"
        case privacySettings = "privacy_settings"
        case loggedin, language
        case trackingUrls = "tracking_urls"
        case recommenderSystem = "recommender_system"
        case recallStartTime = "recall_start_time"
        case vodPagePublicID = "vod_page_public_id"
        case minConnectivity = "min_connectivity"
        case serviceRegionCountry = "service_region_country"
        case html5Streaming = "html5_streaming"
    }
}
