// 
//  StreamSettingsOptionsViewModel.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import AVFoundation.AVPlayer
import RxCocoa

struct StreamSettingsOptionsViewModel {
    
    let localization = StreamSettingsOptionsLocalization()
    let setting: PlayerSettingsUIModel
    let player: AVPlayer
    let settingsDataSource = BehaviorRelay<[PlayerSettingsUIModel]>(value: [])
}
