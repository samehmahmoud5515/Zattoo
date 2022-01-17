//
//  PlayerSettingsUIModel.swift
//  Zattoo
//
//  Created by SAMEH on 13/01/2022.
//

import Foundation

enum PlayerSettingsUIModel {
    case quality(_ quality: VideoQuality, _ resolution: Int, _ enabled: Bool)
    case audio(_ name: Option<String>, _ enabled: Bool)
    case subtitle(_ name: Option<String>, _ enabled: Bool)
    
    var enabled: Bool {
        switch self {
        case let .quality(_, _, enabled): return enabled
        case let .audio(_, enabled): return enabled
        case let .subtitle(_, enabled): return enabled
        }
    }
    
    mutating func enableSetting() {
        switch self {
        case let .quality(Quality, resolution, _):
            self = .quality(Quality, resolution, true)
        case let .audio(audio, _):
            self = .audio(audio, true)
        case let .subtitle(subtitle, _):
        self = .subtitle(subtitle, true)
        }
    }
}

extension PlayerSettingsUIModel: Equatable {
    static func == (lhs: PlayerSettingsUIModel, rhs: PlayerSettingsUIModel) -> Bool {
        switch (lhs, rhs) {
        case let (.quality(lhsQuality, lhsResolution, _), .quality(rhsQuality, rhsResolution,_)):
            return lhsQuality == rhsQuality && lhsResolution == rhsResolution
        case let (.audio(lhsName, _), .audio(rhsName, _)):
            return lhsName == rhsName
        case let (.subtitle(lhsName, _), .subtitle(rhsName, _)):
            return lhsName == rhsName
        default: return false
        }
    }
}
