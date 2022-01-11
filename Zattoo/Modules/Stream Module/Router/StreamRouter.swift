// 
//  StreamRouter.swift
//  Zattoo
//
//  Created by SAMEH on 03/01/2022.
//

import UIKit

class StreamRouter: StreamRouterProtocol {
    
    // MARK: - Route
    enum StreamRoute {
        case close
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    // MARK:- Assemble
    static func assembleModule(channelStream: ChannelStream) -> UIViewController {
        let viewModel = StreamViewModel(channelStream: channelStream)
        let view = StreamViewController()
        let interactor = StreamInteractor()
        let router = StreamRouter()
        let presenter = StreamPresenter(viewModel: viewModel, viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Routing
    func go(to route:StreamRoute) {
        switch route {
        case .close:
            viewController?.dismiss(animated: true)
        }
    }

}
