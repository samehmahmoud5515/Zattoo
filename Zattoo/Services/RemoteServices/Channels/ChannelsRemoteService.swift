//
//  ChannelsRemoteService.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

class ChannelsRemoteService: APIService<ChannelsEndPoint>, ChannelsRemoteServiceProtocol {
    func fetchChannels(powerGuideHash: String) -> Single<ChannelsResponse> {
        return request(target: .getChannels(powerGuideHash: powerGuideHash))
    }
    
    func fetchChannelStreamURL(channelId: String) -> Single<ChannelStreamResponse> {
        return request(target: .getChannelStreamURL(channelId: channelId))
    }
}
