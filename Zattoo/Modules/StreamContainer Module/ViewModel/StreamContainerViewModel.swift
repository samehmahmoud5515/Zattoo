// 
//  StreamContainerViewModel.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import AVFoundation.AVPlayer
import RxSwift
import RxCocoa

struct StreamContainerViewModel {
    let channelStream: ChannelStream
    let player = AVPlayer()
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
