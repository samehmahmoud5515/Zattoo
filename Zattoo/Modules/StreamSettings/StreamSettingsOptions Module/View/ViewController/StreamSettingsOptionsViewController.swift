// 
//  StreamSettingsOptionsViewController.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class StreamSettingsOptionsViewController: UIViewController, StreamSettingsOptionsViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Attributes
	var presenter: StreamSettingsOptionsPresenterProtocol!
    let disposeBag = DisposeBag()

    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - UI Setup
extension StreamSettingsOptionsViewController {
    func setupUI() {
        registerTableViewCell()
    }
    
    func registerTableViewCell() {
        let nib = UINib(nibName: "\(OptionCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(OptionCell.self)")
    }
}

// MARK: - UI Binding
extension StreamSettingsOptionsViewController {
    func configureUIBinding() {
        bindTableViewDataSource()
        bindDidSelectOptionWithModelSelected()
    }
    
    func bindTableViewDataSource() {
        presenter.viewModel.settingsDataSource
            .bind(to: tableView.rx.items(cellIdentifier: "\(OptionCell.self)", cellType: OptionCell.self)) { row, item, cell in
                cell.configure(item)
            }.disposed(by: disposeBag)
    }
    
    private func bindDidSelectOptionWithModelSelected() {
        tableView.rx.modelSelected(PlayerSettingsUIModel.self)
            .bind { [weak self] option in
                self?.presenter?.didSelectOption(option: option)
            }.disposed(by: disposeBag)
    }
}
