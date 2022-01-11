// 
//  StreamContract.swift
//  Zattoo
//
//  Created by SAMEH on 03/01/2022.
//

import RxSwift

// MARK: - Router
protocol StreamRouterProtocol: AnyObject {
    func go(to route:StreamRouter.StreamRoute)
}

// MARK: - Interactor
protocol StreamInteractorProtocol: AnyObject {
}

// MARK: - Presenter
protocol StreamPresenterProtocol: AnyObject {
    func viewDidLoad()
    var viewModel: StreamViewModel { get }
}

//MARK: - View
protocol StreamViewControllerProtocol: AnyObject {
    var presenter: StreamPresenterProtocol!  { get set }
    func setupUI() 
    func configureUIBinding()
}
