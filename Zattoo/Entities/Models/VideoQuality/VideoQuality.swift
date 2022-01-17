//
//  VideoQuality.swift
//  Zattoo
//
//  Created by SAMEH on 17/01/2022.
//

import Foundation

enum VideoQuality: String, CaseIterable {
    case qvga = "QVGA"
    case nHD = "nHD"
    case sd = "SD"
    case hd = "HD"
    case fullHD = "FULL_HD"
    case q4K = "4K"
    case auto = ""
}

extension VideoQuality {
    
    init(quality: String) {
        self = VideoQuality(rawValue: quality) ?? .auto
    }
    
    init(resolution: Int) {
        switch resolution {
        case 0 ... 240: self = .qvga
        case 241 ... 360: self = .nHD
        case 361 ... 480: self = .sd
        case 481 ... 720: self = .hd
        case 721 ... 1080: self = .fullHD
        case 1081 ... 4320: self = .q4K
        default: self = .auto
        }
    }
    
    var heightResolution: Int {
        switch self {
        case .qvga: return 240
        case .nHD: return 360
        case .sd: return 480
        case .hd: return 720
        case .fullHD: return 1080
        case .q4K: return 2160
        case .auto: return 0
        }
    }
    
    var widthResolution: Int {
        switch self {
        case .qvga: return 400
        case .nHD: return 640
        case .sd: return 854
        case .hd: return 1280
        case .fullHD: return 1920
        case .q4K: return 3840
        case .auto: return 0
        }
    }
    
    var name: String {
        switch self {
        case .nHD: return "nHD"
        case .qvga: return "QVGA"
        case .sd: return "SD"
        case .hd: return "HD"
        case .fullHD: return "FHD"
        case .q4K: return "4K"
        case .auto: return "Auto"
        }
    }
    
    var qualityOrder:Int {
        switch self {
        case .auto: return 0
        case .q4K: return 1
        case .fullHD: return 2
        case .hd: return 3
        case .sd: return 4
        case .nHD: return 5
        case .qvga: return 6
        }
    }
}
