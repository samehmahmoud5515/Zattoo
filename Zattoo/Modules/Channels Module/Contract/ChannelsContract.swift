// 
//  ChannelsContract.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation
import RxSwift

// MARK: - Router
protocol ChannelsRouterProtocol: AnyObject {
    func go(to route:ChannelsRouter.ChannelsRoute)
}

// MARK: - Interactor
protocol ChannelsInteractorProtocol: AnyObject {
    func fetchChannels(powerGuideHash: String) -> Observable<([Channel], [Group])>
    func retrievePowerGuideHash() -> Observable<String>
    func fetchChannelStreamURL(channelId: String) -> Observable<ChannelStream>
}

// MARK: - Presenter
protocol ChannelsPresenterProtocol: AnyObject {
    func viewDidLoad()
    var viewModel: ChannelsViewModel { get }
    func updateSelectedGroupIndex(with index: Int)
}

//MARK: - View
protocol ChannelsViewControllerProtocol: AnyObject {
    var presenter: ChannelsPresenterProtocol!  { get set }
    func setupUI()
    func configureUIBinding()
    func reloadGroupCellAt(index: Int)
}

protocol ChannelCellProtocol {
    func updateUI(with title: String, subTitle: String)
}

protocol GroupCellProtocol {
    func updateUI(with group: GroupUIModel, isSelected: Bool) 
}
