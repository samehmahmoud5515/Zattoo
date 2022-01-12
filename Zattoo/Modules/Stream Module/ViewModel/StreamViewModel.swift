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
    let videoGravity: Observable<AVLayerVideoGravity>
}
