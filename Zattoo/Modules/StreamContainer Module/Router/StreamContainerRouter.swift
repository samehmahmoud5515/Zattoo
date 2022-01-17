// 
//  StreamContainerRouter.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import UIKit
import AVFoundation.AVPlayer
import RxSwift

class StreamContainerRouter: StreamContainerRouterProtocol {
    
    // MARK: - Route
    enum StreamContainerRoute {
        case stream(channelStream: ChannelStream, player: AVPlayer, videoGravity: Observable<AVLayerVideoGravity>)
        case close
        case streamSetting(player: AVPlayer)
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    // MARK:- Assemble
    static func assembleModule(channelStream: ChannelStream) -> UIViewController {
        let view = StreamContainerViewController()
        let interactor = StreamContainerInteractor()
        let router = StreamContainerRouter()
        let viewModel = StreamContainerViewModel(channelStream: channelStream)
        let presenter = StreamContainerPresenter(
            viewController: view,
            interactor: interactor,
            router: router,
            viewModel: viewModel)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Routing
    func go(to route:StreamContainerRoute) {
        switch route {
        case let .stream(channelStream, player, videoGravity):
            guard let view = viewController?.view else { return }
            let streamViewController = StreamRouter.assembleModule(channelStream: channelStream, player: player, videoGravity: videoGravity)
            viewController?.add(child: streamViewController, to: view)
        case .close:
            viewController?.remove()
            viewController?.dismiss(animated: true, completion: nil)
        case let .streamSetting(player):
            guard let view = viewController?.view else { return }
            let streamViewController = StreamSettingsRouter.assembleModule(player: player)
            let navigationController = UINavigationController(rootViewController: streamViewController)
            viewController?.add(child: navigationController, to: view)
            //viewController?.presentOver(navigationController, animated: true, completion: nil)
        }
    }

}
