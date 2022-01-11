// 
//  SplashContract.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation
import RxSwift

// MARK: - Router
protocol SplashRouterProtocol: AnyObject {
    func go(to route:SplashRouter.SplashRoute)
}

// MARK: - Interactor
protocol SplashInteractorProtocol: AnyObject {
    func startSession() -> Observable<Session>
    func login() -> Observable<LoginSession>
    func save(powerGuideHash: String) -> Observable<()>
}

// MARK: - Presenter
protocol SplashPresenterProtocol: AnyObject {
    func viewDidLoad()
    var viewModel: SplashViewModel  { get }
    
}

//MARK: - View
protocol SplashViewControllerProtocol: AnyObject {
    var presenter: SplashPresenterProtocol!  { get set }
    func configureUIBinding()
}
