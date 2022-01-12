// 
//  StreamRouter.swift
//  Zattoo
//
//  Created by SAMEH on 03/01/2022.
//

import UIKit
import AVFoundation.AVPlayer
import RxSwift

class StreamRouter: StreamRouterProtocol {
    
    // MARK: - Route
    enum StreamRoute {
        
    }
    
    // MARK: - Attributes
    weak var viewController: UIViewController?
    
    // MARK:- Assemble
    static func assembleModule(
        channelStream: ChannelStream,
        player: AVPlayer,
        videoGravity: Observable<AVLayerVideoGravity>) -> UIViewController {
        
        let viewModel = StreamViewModel(channelStream: channelStream, videoGravity: videoGravity)
        let view = StreamViewController()
        view.player = player
        let interactor = StreamInteractor()
        let router = StreamRouter()
        let presenter = StreamPresenter(viewModel: viewModel, viewController: view, interactor: interactor, router: router)
        
        view.presenter = presenter
        router.viewController = view
        
        return view
    }
    
    // MARK: - Routing
    func go(to route:StreamRoute) {
    }

}
