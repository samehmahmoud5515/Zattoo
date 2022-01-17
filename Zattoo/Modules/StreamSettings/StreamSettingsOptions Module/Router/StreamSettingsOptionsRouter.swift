// 
//  StreamSettingsOptionsRouter.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import UIKit
import AVFoundation.AVPlayer

class StreamSettingsOptionsRouter: StreamSettingsOptionsRouterProtocol {
    
    // MARK: - Route
    enum StreamSettingsOptionsRoute {
        case dismiss
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    // MARK:- Assemble
    static func assembleModule(setting: PlayerSettingsUIModel, player: AVPlayer) -> UIViewController {
        let view = StreamSettingsOptionsViewController()
        let interactor = StreamSettingsOptionsInteractor()
        let router = StreamSettingsOptionsRouter()
        let viewModel = StreamSettingsOptionsViewModel(setting: setting, player: player)
        let presenter = StreamSettingsOptionsPresenter(viewController: view, interactor: interactor, router: router, viewModel: viewModel)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Routing
    func go(to route: StreamSettingsOptionsRoute) {
        switch route {
        case .dismiss:
            viewController?.navigationController?.remove()
        }
    }

}
