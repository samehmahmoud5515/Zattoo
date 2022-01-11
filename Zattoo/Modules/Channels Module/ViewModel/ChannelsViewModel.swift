// 
//  ChannelsViewModel.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

struct ChannelsViewModel {
    
    let localization =  ChannelsLocalization()
    let isLoading = PublishSubject<Bool>()
    let channelsDataSource = PublishSubject<[Channel]>()
    let filteredChannelsDataSource = PublishSubject<[Channel]>()
    let groupsDataSource = PublishSubject<[GroupUIModel]>()
    let selectedGroup = PublishSubject<GroupUIModel>()
    var selectedGroupIndex: Int?
    let selectedChannel = PublishSubject<Channel>()
}
