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
    
    var currentItem: Observable<AVPlayerItem?> {
        return observe(AVPlayerItem.self, #keyPath(AVPlayer.currentItem))
    }
    
    var preferredMaximumResolution: Observable<CGSize?> {
        return observe(CGSize.self, #keyPath(AVPlayer.currentItem.preferredMaximumResolution))
    }
    
    var presentationSize: Observable<CGSize?> {
        return observe(CGSize.self, #keyPath(AVPlayer.currentItem.presentationSize))
    }
    
    func periodicTimeObserver(timeInterval: CMTime, queue: DispatchQueue?) -> Observable<CMTime> {
        return Observable.create { observer in
            let time = self.base.addPeriodicTimeObserver(forInterval: timeInterval, queue: queue) { time in
                observer.onNext(time)
            }
            return Disposables.create {
                self.base.removeTimeObserver(time)
            }
        }
    }
}
