//
//  Tracking.swift
//  Zattoo
//
//  Created by SAMEH on 02/01/2022.
//

import Foundation

// MARK: - Tracking
struct Tracking: Codable {
    var latencyMeasurementInterval: Int?
    var eventPixel: String?

    enum CodingKeys: String, CodingKey {
        case latencyMeasurementInterval = "latency_measurement_interval"
        case eventPixel = "event_pixel"
    }
}
