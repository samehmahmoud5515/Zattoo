// 
//  StreamPresenter.swift
//  Zattoo
//
//  Created by SAMEH on 03/01/2022.
//

import RxSwift

class StreamPresenter: StreamPresenterProtocol {
    
    // MARK: - Attributes
    weak var viewController: StreamViewControllerProtocol?
    let interactor: StreamInteractorProtocol
    let router: StreamRouterProtocol
    let viewModel: StreamViewModel
    let disposeBag = DisposeBag()

    // MARK: - init
    init(
        viewModel: StreamViewModel,
        viewController: StreamViewControllerProtocol,
        interactor: StreamInteractorProtocol,
        router: StreamRouterProtocol) {
        self.viewModel = viewModel
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        viewController?.setupUI() 
        viewController?.configureUIBinding()
        bindCloseWithCloseButtonDidTapped()
    }
    
    // MARK: - Methods
    func bindCloseWithCloseButtonDidTapped() {
        viewModel.closeButtonDidTapped
            .subscribe { [weak self] _ in
                self?.router.go(to: .close)
            }.disposed(by: disposeBag)
    }
}
