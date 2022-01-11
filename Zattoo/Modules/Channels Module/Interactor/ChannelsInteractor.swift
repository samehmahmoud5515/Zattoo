// 
//  ChannelsInteractor.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

class ChannelsInteractor: ChannelsInteractorProtocol {
    // MARK: - Attribuites
    let sessionlocalService: StreamSessionLocalServiceProtocol
    let channelsRemoteService: ChannelsRemoteServiceProtocol
    
    // MARK: - init
    init(sessionlocalService: StreamSessionLocalServiceProtocol,
         channelsRemoteService: ChannelsRemoteServiceProtocol) {
        self.sessionlocalService = sessionlocalService
        self.channelsRemoteService = channelsRemoteService
    }

    func retrievePowerGuideHash() -> Observable<String> {
        return sessionlocalService
            .retrievePowerGuideHash()
            .asObservable()
    }
    
    func fetchChannels(powerGuideHash: String) -> Observable<([Channel], [Group])> {
        return channelsRemoteService
            .fetchChannels(powerGuideHash: powerGuideHash)
            .asObservable()
            .flatMap { response -> Observable<([Channel], [Group])> in
                guard let channels = response.channels,
                      let groups = response.groups else {
                    return Observable.error(ChannelsServiceError.notFound)
                }
                return Observable.just((channels, groups))
            }
    }
    
    func fetchChannelStreamURL(channelId: String) -> Observable<ChannelStream> {
        return channelsRemoteService
            .fetchChannelStreamURL(channelId: channelId)
            .asObservable()
            .flatMap { response -> Observable<ChannelStream> in
                guard let streamModel = response.stream else {
                    return Observable.error(ChannelsServiceError.notFound)
                }
                return Observable.just(streamModel)
            }
    }
}
