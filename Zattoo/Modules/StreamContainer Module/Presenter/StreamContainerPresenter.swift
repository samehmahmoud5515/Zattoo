// 
//  StreamContainerPresenter.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import RxSwift

class StreamContainerPresenter: StreamContainerPresenterProtocol {
    
    // MARK: - Attributes
    weak var viewController: StreamContainerViewControllerProtocol?
    let interactor: StreamContainerInteractorProtocol
    let router: StreamContainerRouterProtocol
    let viewModel: StreamContainerViewModel
    let disposeBag = DisposeBag()

    // MARK: - init
    init(
        viewController: StreamContainerViewControllerProtocol,
        interactor: StreamContainerInteractorProtocol,
        router: StreamContainerRouterProtocol,
        viewModel: StreamContainerViewModel) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
        self.viewModel = viewModel
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        bindPlayerActions()
        viewController?.setupUI()
        viewController?.configureUIBinding()
    }
    
    // MARK: - Methods
    func addStream(to view: UIView) {
        router.go(to: .stream(
                    channelStream: viewModel.channelStream,
                    player: viewModel.player,
                    view: view,
                    videoGravity: viewModel.videoGravity))
    }
    
    func bindPlayerActions() {
        viewModel.closeButtonDidTapped.bind { [weak self] action in
            self?.router.go(to: .close)
        }.disposed(by: disposeBag)
    }
}
