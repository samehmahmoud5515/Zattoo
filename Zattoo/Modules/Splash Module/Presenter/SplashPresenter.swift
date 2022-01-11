// 
//  SplashPresenter.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit
import RxSwift

class SplashPresenter: SplashPresenterProtocol {
    
    // MARK: - Attributes
    weak var viewController: SplashViewControllerProtocol?
    let interactor: SplashInteractorProtocol
    let router: SplashRouterProtocol
    var viewModel =  SplashViewModel ()
    let disposeBag = DisposeBag()

    // MARK: - init
    init(viewController: SplashViewControllerProtocol, interactor: SplashInteractorProtocol, router: SplashRouterProtocol) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        viewController?.configureUIBinding()
        viewModel.isLoading.onNext(true)
        loadStreamSession()
    }
    
    func loadStreamSession() {
        interactor.startSession()
            .catch { error -> Observable<Session> in
                return Observable.empty()
            }
            .flatMap { [weak self] _ -> Observable<LoginSession> in
                return self?.login() ?? Observable.empty()
            }.flatMap { [weak self] loginSession -> Observable<()> in
                guard let powerGuideHash = loginSession.powerGuideHash else {
                    return Observable.empty() }
                return self?.interactor.save(powerGuideHash: powerGuideHash) ?? Observable.empty()
            }
            .observe(on: MainScheduler.instance)
            .do { [weak self] _ in
                self?.viewModel.isLoading.onNext(false)
                self?.router.go(to: .channels)
            }
            .subscribe()
            .disposed(by: disposeBag)

    }
    
    func login() -> Observable<LoginSession> {
        return interactor.login()
            .catch { error -> Observable<LoginSession> in
                return Observable.empty()
            }
    }
}
