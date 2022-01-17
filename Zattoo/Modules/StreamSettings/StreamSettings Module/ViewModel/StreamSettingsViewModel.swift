// 
//  StreamSettingsViewModel.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import AVFoundation.AVPlayer
import RxCocoa

struct StreamSettingsViewModel {
    
    let localization = StreamSettingsLocalization()
    let player: AVPlayer
    let dataSource = BehaviorRelay<[PlayerSettingsUIModel]>(value: [])
    let cancelButtonDidTapped = PublishRelay<()>()
    
}

extension StreamSettingsViewModel {
    func localize(setting: PlayerSettingsUIModel) -> String {
        
        switch setting {
        case .quality: return "Quality"
        case .audio: return "Audio"
        case .subtitle: return "Subtitle"
        }
    }
        
    func image(for setting: PlayerSettingsUIModel) -> UIImage? {
        switch setting {
        case .quality: return UIImage(named: "live-stream-settings-quality")
        case .audio: return UIImage(named: "live-stream-settings-audio")
        case .subtitle: return UIImage(named: "live-stream-settings-subtitle")
        }
    }
}
