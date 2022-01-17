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
                self?.configure(cell: cell, with: item)
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

extension StreamSettingsViewController {
    private func configure(cell: StreamSettingsCell, with setting: PlayerSettingsUIModel) {
        guard let viewModel = presenter?.viewModel
        else { return }
        
        cell.titleLbl.text = viewModel.localize(setting: setting)
        
        //cell.iconImgView.image = viewModel.image(for: setting)
        cell.contentView.alpha = setting.enabled ? 1.0 : 0.5
        
        switch setting {
        case let .quality(quality, _, _):
            
            var resolutionText = .auto == quality ? "Auto" : quality.name
            let lastIndex = resolutionText.count

            if quality.heightResolution >= VideoQuality.hd.heightResolution {
                resolutionText.append("HD")
                cell.valueLbl.setAttributedTextWithSubscripts(text: resolutionText,
                                                              indicesOfSubscripts: [lastIndex ,
                                                                                    lastIndex + 1], color: .red)
            }
            else {
                cell.valueLbl.text = resolutionText
            }
            
        case let .audio(name, _):
            displaySettingOption(name, cell)
        case let .subtitle(name, _):
            displaySettingOption(name, cell)
        }
    }

    private func displaySettingOption(_ name: Option<String>, _ cell: StreamSettingsCell) {

        switch name {
        case let .value(value):
            cell.valueLbl.text = value
        case .none:
            cell.valueLbl.text = "None"
        }
    }
}

extension UILabel {
    func setAttributedTextWithSubscripts(text: String, indicesOfSubscripts: [Int], color: UIColor) {
        let font = self.font!
        let subscriptFont = font.withSize(font.pointSize * 0.7)
        let subscriptOffset = font.pointSize * 0.3
        let attributedString = NSMutableAttributedString(string: text,
                                                         attributes: [.font : font])
        for index in indicesOfSubscripts {
            let range = NSRange(location: index, length: 1)
            attributedString.setAttributes([.font: subscriptFont,
                                            .baselineOffset: subscriptOffset,
                                            .foregroundColor: color],
                                           range: range)
        }
        self.attributedText = attributedString
    }
}
