//
//  AVAudioSession+Extension.swift
//  Zattoo
//
//  Created by SAMEH on 11/01/2022.
//

import AVFoundation
import RxSwift

extension Reactive where Base: AVAudioSession {
    public var outputVolume: Observable<Float> {
        return observe(Float.self, #keyPath(AVAudioSession.outputVolume))
            .map { $0 ?? 0.0 }
    }
}
