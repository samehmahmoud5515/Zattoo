//
//  AVPlayerItem+Extension.swift
//  Zattoo
//
//  Created by SAMEH on 14/01/2022.
//

import AVFoundation

//MARK: - Tracks
extension AVPlayerItem {
    
     enum TrackType {
        case subtitle
        case audio
        case video
        
        var characteristicsOption: AVMediaCharacteristic {
            switch self {
            case .subtitle: return .legible
            case .audio: return .audible
            case .video: return .visual
            }
        }
        
        func characteristic(item:AVPlayerItem) -> AVMediaSelectionGroup?  {
            if item.asset.availableMediaCharacteristicsWithMediaSelectionOptions.contains(characteristicsOption) {
                return item.asset.mediaSelectionGroup(forMediaCharacteristic: characteristicsOption)
            }
            return nil
        }
    }
    
}

// MARK: - Track Selection
extension AVPlayerItem {
    func selectTrack(type: AVPlayerItem.TrackType, name: String) {
        guard let group = type.characteristic(item: self)
        else { return   }
        guard let matched = group.options
                .filter({ $0.displayName == name }).first
        else { return }
        self.select(matched, in: group)
    }
}
