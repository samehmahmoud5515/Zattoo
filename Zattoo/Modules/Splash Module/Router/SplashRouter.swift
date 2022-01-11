// 
//  SplashRouter.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit

class SplashRouter: SplashRouterProtocol {
    
    // MARK: - Route
    enum SplashRoute {
        case channels
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    // MARK:- Assemble
    static func assembleModule() -> UIViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor(
            sessionRemoteService: StreamSessionRemoteService(),
            sessionlocalService: StreamSessionLocalService())
        let router = SplashRouter()
        let presenter = SplashPresenter(viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Routing
    func go(to route:SplashRoute) {
        switch route {
        case .channels:
            let channelsViewController = ChannelsRouter.assembleModule()
            viewController?.navigationController?.setViewControllers([channelsViewController], animated: false) 
        }
    }

}
