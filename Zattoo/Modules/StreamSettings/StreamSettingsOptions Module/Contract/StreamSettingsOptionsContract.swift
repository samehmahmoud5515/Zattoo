// 
//  StreamSettingsOptionsContract.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import Foundation
import RxSwift

// MARK: - Router
protocol StreamSettingsOptionsRouterProtocol: AnyObject {
    func go(to route:StreamSettingsOptionsRouter.StreamSettingsOptionsRoute)
}

// MARK: - Interactor
protocol StreamSettingsOptionsInteractorProtocol: AnyObject {
}

// MARK: - Presenter
protocol StreamSettingsOptionsPresenterProtocol: AnyObject {
    func viewDidLoad()
    var viewModel: StreamSettingsOptionsViewModel  { get }
    func didSelectOption(option: PlayerSettingsUIModel)
}

//MARK: - View
protocol StreamSettingsOptionsViewControllerProtocol: AnyObject {
    var presenter: StreamSettingsOptionsPresenterProtocol!  { get set }
    func setupUI()
    func configureUIBinding()
}
