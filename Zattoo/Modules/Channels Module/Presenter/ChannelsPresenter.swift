// 
//  ChannelsPresenter.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit
import RxSwift

class ChannelsPresenter: ChannelsPresenterProtocol {
    
    // MARK: - Attributes
    weak var viewController: ChannelsViewControllerProtocol?
    let interactor: ChannelsInteractorProtocol
    let router: ChannelsRouterProtocol
    var viewModel = ChannelsViewModel()
    let disposeBag = DisposeBag()

    // MARK: - init
    init(
        viewController: ChannelsViewControllerProtocol,
        interactor: ChannelsInteractorProtocol,
        router: ChannelsRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        viewController?.setupUI()
        viewController?.configureUIBinding()
        viewModel.isLoading.onNext(true)
        fetchChannels()
        bindFilteredChannelsDataSourceWithSelectedGroup()
        bindFetchChannelURLWithSelectedChannel()
    }
    
    // MARK: - Methods
    func fetchChannels() {
        interactor.retrievePowerGuideHash()
            .flatMap { [weak self] powerGuideHash -> Observable<([Channel], [Group])> in
                return self?.interactor
                    .fetchChannels(powerGuideHash: powerGuideHash)
                    .catch { error -> Observable<([Channel], [Group])> in
                        return Observable.empty()
                    } ?? Observable.empty()
            }
            .map { ($0.0, $0.1.map { group -> GroupUIModel in
                    return GroupUIModel(id: group.id, name: group.name ?? "") })}
            .do { [weak self] channels, groups in
                guard let self = self else { return }
                let all = self.viewModel.localization.all
                var updatedGroups = groups
                updatedGroups.insert(GroupUIModel(id: -1, name: all, groupType: .all), at: 0)
                self.viewModel.selectedGroupIndex = 0
                self.viewModel.channelsDataSource.onNext(channels)
                self.viewModel.filteredChannelsDataSource.onNext(channels)
                self.viewModel.groupsDataSource.onNext(updatedGroups)
                self.viewModel.isLoading.onNext(false)
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func bindFilteredChannelsDataSourceWithSelectedGroup() {
        viewModel.selectedGroup
            .withLatestFrom(viewModel.channelsDataSource) { ($0, $1) }
            .flatMap { selectedGroup, channels -> Observable<[Channel]> in
                switch selectedGroup.groupType {
                case .all:
                    return Observable.just(channels)
                case .other:
                    let filterdChannels = channels
                        .filter { ($0.groupIDS?.contains(selectedGroup.id ?? -1) ?? false) }
                    return Observable.just(filterdChannels)
                }
            }
            .bind(to: viewModel.filteredChannelsDataSource)
            .disposed(by: disposeBag)
    }
    
//    func bindSelectedGroupWithGroupsDataSource() {
//        viewModel.selectedGroup
//            .withLatestFrom(viewModel.groupsDataSource) { ($0, $1) }
//            .flatMap { selectedGroup, groups -> Observable<[GroupUIModel]> in
//                var updateGroups = groups
//                for i in 0..<groups.count {
//                    if groups[i] == selectedGroup {
//                        updateGroups[i].isSelected = true
//                    } else {
//                        updateGroups[i].isSelected = false
//                    }
//                }
//                return Observable.just(updateGroups)
//            }
//            .bind(to: viewModel.groupsDataSource)
//            .disposed(by: disposeBag)
//    }
    
    func bindFetchChannelURLWithSelectedChannel() {
        viewModel.selectedChannel
            .do(onNext: { [weak self] _ in
                self?.viewModel.isLoading.onNext(true)
            })
            .compactMap { $0.cid }
            .flatMap { [weak self] channelId -> Observable<ChannelStream> in
                return self?.fetchChannelStreamURL(channelId: channelId) ?? Observable.empty()
            }
            .observe(on: MainScheduler.instance)
            .do { [weak self] channelStream in
                self?.viewModel.isLoading.onNext(false)
                self?.router.go(to: .stream(channelStream: channelStream))
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func fetchChannelStreamURL(channelId: String) -> Observable<ChannelStream> {
        return interactor
            .fetchChannelStreamURL(channelId: channelId)
            .catch { [weak self] error -> Observable<ChannelStream> in
                self?.viewModel.isLoading.onNext(false)
                return Observable.empty()
            }
    }
    
    func updateSelectedGroupIndex(with index: Int) {
        viewModel.selectedGroupIndex = index
        viewController?.reloadGroupCellAt(index: index)
    }
}
