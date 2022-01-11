//
//  ChannelsRemoteServiceProtocol.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

protocol ChannelsRemoteServiceProtocol {
    func fetchChannels(powerGuideHash: String) -> Single<ChannelsResponse>
    func fetchChannelStreamURL(channelId: String) -> Single<ChannelStreamResponse>
}
