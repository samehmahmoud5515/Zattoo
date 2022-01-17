//
//  AVAsset+RxExtension.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import AVFoundation
import RxSwift

extension Reactive where Base: AVAsset {
    var tracks: Observable<[AVAssetTrack]> {
        return self.base.rx.loadValuesAsynchronously(for: "tracks")
            .flatMap { _ in Observable.just(self.base.tracks)  }
    }
    
    func loadValuesAsynchronously(for key: String) -> Observable<Bool> {
        return Observable.create { observer in
            self.base.loadValuesAsynchronously(forKeys: [key]) {
                var error: NSError?
                let status = self.base.statusOfValue(forKey: key, error: &error)
                switch status {
                case .loaded:
                    observer.onNext(true)
                    observer.onCompleted()
                default:
                    observer.onNext(false)
                    observer.onCompleted()
                }
            }
            return Disposables.create()
        }
    }
}
