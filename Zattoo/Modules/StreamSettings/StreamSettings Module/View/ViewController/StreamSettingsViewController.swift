// 
//  StreamSettingsViewController.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class StreamSettingsViewController: UIViewController, StreamSettingsViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Views
    let cancelButton = UIButton()
    
    // MARK: - Attributes
	var presenter: StreamSettingsPresenterProtocol!
    let disposeBag = DisposeBag()

    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    deinit {
        print("\(StreamSettingsViewController.self) deint")
    }
}

// MARK: - UI Setup
extension StreamSettingsViewController {
    func setupUI() {
        regsiterTableViewCell()
        setupTableViewRowHeight()
        setupNavigationView()
    }
    
    func regsiterTableViewCell() {
        let nib = UINib(nibName: "\(StreamSettingsCell.self)", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "\(StreamSettingsCell.self)")
    }
    
    func setupTableViewRowHeight() {
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    private func setupNavigationView() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.barTintColor = .primaryColor
        navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.tintColor = .white
        
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.textColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
}

// MARK: - UI Binding
extension StreamSettingsViewController {
    func configureUIBinding() {
        bindCancelButtonTap()
        bindTableViewDataSource()
        didSelectSettingModel()
    }
    
    func bindCancelButtonTap() {
        cancelButton.rx.tap
            .bind(to: presenter.viewModel.cancelButtonDidTapped)
            .disposed(by: disposeBag)
    }
    
    func bindTableViewDataSource() {
        presenter.viewModel.dataSource
            .bind(to: tableView.rx.items(cellIdentifier: "\(StreamSettingsCell.self)", cellType: StreamSettingsCell.self)) { [weak self] row, item, cell in
                guard let viewModel = self?.presenter.viewModel else { return }
                cell.configure(with: item, title: viewModel.localize(setting: item), icon: viewModel.image(for: item))
            }.disposed(by: disposeBag)
    }
    
    func didSelectSettingModel() {
        tableView.rx.modelSelected(PlayerSettingsUIModel.self)
            .do(onNext: { [weak self] setting in
                guard let self = self,
                      let presenter = self.presenter,
                      setting.enabled
                else { return }
                
                presenter.navigateToSettingsSelections(setting: setting)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
