//
//  AVPlayerRx.swift
//  Zattoo
//
//  Created by SAMEH on 11/01/2022.
//

import AVFoundation
import RxSwift
import RxCocoa

extension Reactive where Base: AVPlayer {
    var timeControlStatus: Observable<AVPlayer.TimeControlStatus> {
        return observe(AVPlayer.TimeControlStatus.self, #keyPath(AVPlayer.timeControlStatus))
            .map { $0 ?? .waitingToPlayAtSpecifiedRate }
    }
}
