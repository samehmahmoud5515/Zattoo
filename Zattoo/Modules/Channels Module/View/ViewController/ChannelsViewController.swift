// 
//  ChannelsViewController.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class ChannelsViewController: UIViewController, ChannelsViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var groupsCollectionView: UICollectionView!
    @IBOutlet weak var channelsCollectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Attributes
    var presenter: ChannelsPresenterProtocol!
    let disposeBag = DisposeBag()
    var numberOfRowsForChannels: CGFloat = 2
    
    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        channelsCollectionView.rx.setDelegate(self).disposed(by: disposeBag)
        presenter.viewDidLoad()
    }
    
}

// MARK: - UI Setup
extension ChannelsViewController {
    func setupUI() {
        setupNavigationView()
        registerGroupsCollectionViewCell()
        registerChannelsCollectionViewCell()
        setupGroupsCollectionViewFlowLayout()
        setupChannelsCollectionViewFlowLayout()
        bindChannelCollectionViewSelection()
    }
    
    private func setupNavigationView() {
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = "Channels"
    }
    
    private func registerGroupsCollectionViewCell() {
        let nib = UINib(nibName: "\(GroupCell.self)", bundle: nil)
        groupsCollectionView.register(nib, forCellWithReuseIdentifier: "\(GroupCell.self)")
    }
    
    private func registerChannelsCollectionViewCell() {
        let nib = UINib(nibName: "\(ChannelCell.self)", bundle: nil)
        channelsCollectionView.register(nib, forCellWithReuseIdentifier: "\(ChannelCell.self)")
    }
    
    private func setupGroupsCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = UICollectionViewFlowLayout.automaticSize
        layout.estimatedItemSize = CGSize(width: 25, height: 25)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 23, bottom: 0, right: 16)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 24
        groupsCollectionView.setCollectionViewLayout(layout, animated: false)
    }
    
    private func setupChannelsCollectionViewFlowLayout() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let horizontalInset: CGFloat = 16
        let cellSpacing: CGFloat = 16
        let itemWidth = (channelsCollectionView.bounds.width - ((horizontalInset * 2) + cellSpacing)) / numberOfRowsForChannels
        layout.itemSize = CGSize(width: itemWidth, height: 280)
        layout.sectionInset = UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        channelsCollectionView.setCollectionViewLayout(layout, animated: false)
    }
}

// MARK: - UI Binding
extension ChannelsViewController {
    func configureUIBinding() {
        bindGroupsCollectionViewDataSource()
        bindChannelsCollectionViewDataSource()
        bindActivityIndicator()
        bindGroupCollectionViewSelection()
    }
    
    func bindGroupsCollectionViewDataSource() {
        presenter.viewModel.groupsDataSource
            .bind(to: groupsCollectionView.rx.items(cellIdentifier: "\(GroupCell.self)", cellType: GroupCell.self)) { [weak self] row, item, cell in
                let indexPath = IndexPath(row: row, section: 0)
                let isSelected = self?.presenter.viewModel.selectedGroupIndex == row
                isSelected ? self?.groupsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally) : ()
                cell.updateUI(with: item, isSelected: isSelected)
            }.disposed(by: disposeBag)
    }
        
    func bindChannelsCollectionViewDataSource() {
        presenter.viewModel.filteredChannelsDataSource
            .bind(to: channelsCollectionView.rx.items(cellIdentifier: "\(ChannelCell.self)", cellType: ChannelCell.self)) { row, item, cell in
                cell.updateUI(with: "\(item.number ?? 0) : \(item.title ?? "")", subTitle: item.qualities?.first?.level?.rawValue ?? "")
            }.disposed(by: disposeBag)
    }
    
    func bindActivityIndicator() {
        presenter.viewModel
            .isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
    
    func bindGroupCollectionViewSelection() {
        groupsCollectionView.rx
            .modelSelected(GroupUIModel.self)
            .bind(to: presenter.viewModel.selectedGroup)
            .disposed(by: disposeBag)
        
        groupsCollectionView.rx
            .itemSelected
            .map { $0.row }
            .subscribe(onNext: { [weak self] index in
                self?.presenter.updateSelectedGroupIndex(with: index)
            })
            .disposed(by: disposeBag)
    }
        
    func bindChannelCollectionViewSelection() {
        channelsCollectionView.rx
            .modelSelected(Channel.self)
            .bind(to: presenter.viewModel.selectedChannel)
            .disposed(by: disposeBag)
    }
    
    func reloadGroupCellAt(index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        groupsCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
    }
}

extension ChannelsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard collectionView == channelsCollectionView else {
            return UICollectionViewFlowLayout.automaticSize }
        
        let flowayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowayout?.minimumInteritemSpacing ?? 0.0) + (flowayout?.sectionInset.left ?? 0.0) + (flowayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / numberOfRowsForChannels
        return CGSize(width: size, height: 280)
    }
}

//extension ChannelsViewController {
//    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
//        super.viewWillTransition(to: size, with: coordinator)
//        if UIDevice.current.orientation.isLandscape {
//            numberOfRowsForChannels = 4
//        } else {
//            numberOfRowsForChannels = 2
//        }
//        channelsCollectionView.reloadData()
//    }
//}
