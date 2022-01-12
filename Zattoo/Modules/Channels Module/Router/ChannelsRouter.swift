// 
//  ChannelsRouter.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit

class ChannelsRouter: ChannelsRouterProtocol {
    
    // MARK: - Route
    enum ChannelsRoute {
        case stream(channelStream: ChannelStream)
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    // MARK:- Assemble
    static func assembleModule() -> UIViewController {
        let view = ChannelsViewController()
        let interactor = ChannelsInteractor(
            sessionlocalService: StreamSessionLocalService(),
            channelsRemoteService: ChannelsRemoteService())
        let router = ChannelsRouter()
        let presenter = ChannelsPresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Routing
    func go(to route:ChannelsRoute) {
        switch route {
        case let .stream(channelStream):
            let streamViewController = StreamContainerRouter.assembleModule(channelStream: channelStream)
            streamViewController.modalPresentationStyle = .overCurrentContext
            viewController?.navigationController?.present(streamViewController, animated: true, completion: nil)
        }
    }

}
