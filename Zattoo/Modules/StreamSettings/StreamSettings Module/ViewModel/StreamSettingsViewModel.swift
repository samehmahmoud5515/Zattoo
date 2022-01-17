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
        case .quality: return UIImage(systemName: "4k.tv.fill")
        case .audio: return UIImage(systemName: "speaker.zzz.fill")
        case .subtitle: return UIImage(systemName: "text.bubble.fill")
        }
    }
}
