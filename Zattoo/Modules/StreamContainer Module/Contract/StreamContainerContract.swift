// 
//  StreamContainerContract.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import RxSwift

// MARK: - Router
protocol StreamContainerRouterProtocol: AnyObject {
    func go(to route:StreamContainerRouter.StreamContainerRoute)
}

// MARK: - Interactor
protocol StreamContainerInteractorProtocol: AnyObject {
}

// MARK: - Presenter
protocol StreamContainerPresenterProtocol: AnyObject {
    func viewDidLoad()
    var viewModel: StreamContainerViewModel { get }
}

//MARK: - View
protocol StreamContainerViewControllerProtocol: AnyObject {
    var presenter: StreamContainerPresenterProtocol!  { get set }
    func setupUI()
    func configureUIBinding()
}
