//
//  AVPlayerItem+RxExtension.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import AVFoundation
import RxSwift

extension Reactive where Base: AVPlayerItem {
    var status: Observable<AVPlayerItem.Status?> {
        return observe(AVPlayerItem.Status.self, #keyPath(AVPlayerItem.status))
    }
    
    var loadedTimeRanges: Observable<[CMTimeRange]> {
        return self.observe([NSValue].self, #keyPath(AVPlayerItem.loadedTimeRanges))
            .map { $0 ?? [] }
            .map { values in values.map { $0.timeRangeValue } }
    }
        
    var presentationSize: Observable<CGSize> {
        return observe(CGSize.self, #keyPath(AVPlayerItem.presentationSize))
            .compactMap { $0 }
    }
    
    var preferredMaximumResolution: Observable<CGSize> {
        return observe(CGSize.self, #keyPath(AVPlayerItem.preferredMaximumResolution))
            .compactMap { $0 }
    }
    
    var duration: Observable<CMTime> {
        return self.observe(CMTime.self, #keyPath(AVPlayerItem.duration))
            .map { $0 ?? .zero }
    }
    
    var assetTracks: Observable<[AVAssetTrack]> {
        return self.base.asset.rx.tracks
            .compactMap {$0}
    }
    
    var tracks: Observable<[AVPlayerItemTrack]?> {
        return observe([AVPlayerItemTrack].self, #keyPath(AVPlayerItem.tracks))
    }
    
    func tracks(type: AVPlayerItem.TrackType) -> Observable<[String]> {
        return tracks.flatMap { _ -> Observable<[String]> in
            guard let characteristic = type.characteristic(item: self.base)
            else { return Observable.just([]) }
            let tracks = characteristic.options.map { $0.displayName }
            return Observable.just(tracks)
        }
    }
    
    func selectedTrack(type: AVPlayerItem.TrackType) -> Observable<String?> {
        guard let group = type.characteristic(item: base)
            else { return Observable.just(nil) }
        let selected = base.currentMediaSelection.selectedMediaOption(in: group)
        base.select(selected, in: group)
        return Observable.just(selected?.displayName)
    }
}
