// 
//  StreamViewModel.swift
//  Zattoo
//
//  Created by SAMEH on 03/01/2022.
//

import RxCocoa
import RxSwift
import AVFoundation

struct StreamViewModel {
    
    let channelStream: ChannelStream
    let closeButtonDidTapped = PublishRelay<()>()
    let resizeButtonDidTapped = PublishRelay<()>()
    let videoGravities: [AVLayerVideoGravity] = [.resize, .resizeAspect, .resizeAspectFill]
    var selectedVideoGravityIndex = BehaviorSubject<Int>(value: 1)
    var videoGravity: Observable<AVLayerVideoGravity> {
        resizeButtonDidTapped
            .withLatestFrom(selectedVideoGravityIndex)
            .map { ($0 + 1) % videoGravities.count }
            .do {
                self.selectedVideoGravityIndex.onNext($0)
            }
            .map { videoGravities[$0] }
    }
}
