// 
//  StreamSettingsRouter.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import UIKit
import AVFoundation.AVPlayer

class StreamSettingsRouter: StreamSettingsRouterProtocol {
    
    // MARK: - Route
    enum StreamSettingsRoute {
        case close
        case options(setting: PlayerSettingsUIModel, player: AVPlayer)
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    // MARK:- Assemble
    static func assembleModule(player: AVPlayer) -> UIViewController {
        let view = StreamSettingsViewController()
        let interactor = StreamSettingsInteractor()
        let router = StreamSettingsRouter()
        let viewModel = StreamSettingsViewModel(player: player)
        let presenter = StreamSettingsPresenter(
            viewController: view,
            interactor: interactor,
            router: router,
            viewModel: viewModel)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Routing
    func go(to route: StreamSettingsRoute) {
        switch route {
        case .close:
            viewController?.navigationController?.remove()
        case let .options(setting, player):
            let streamSettingsOptionsViewController = StreamSettingsOptionsRouter.assembleModule(setting: setting, player: player)
            viewController?.navigationController?.pushViewController(streamSettingsOptionsViewController, animated: true)
        }
    }

}
