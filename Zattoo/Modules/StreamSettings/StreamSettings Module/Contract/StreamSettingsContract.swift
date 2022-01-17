// 
//  StreamSettingsContract.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import Foundation
import RxSwift

// MARK: - Router
protocol StreamSettingsRouterProtocol: AnyObject {
    func go(to route:StreamSettingsRouter.StreamSettingsRoute)
}

// MARK: - Interactor
protocol StreamSettingsInteractorProtocol: AnyObject {
}

// MARK: - Presenter
protocol StreamSettingsPresenterProtocol: AnyObject {
    func viewDidLoad()
    var viewModel: StreamSettingsViewModel  { get }
    func navigateToSettingsSelections(setting: PlayerSettingsUIModel)
}

//MARK: - View
protocol StreamSettingsViewControllerProtocol: AnyObject {
    var presenter: StreamSettingsPresenterProtocol!  { get set }
    func setupUI()
    func configureUIBinding()
}
