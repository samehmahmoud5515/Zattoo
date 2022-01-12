// 
//  StreamContainerViewController.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class StreamContainerViewController: UIViewController, StreamContainerViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var streamOverlayView: StreamOverlayView!
    
    // MARK: - Attributes
	var presenter: StreamContainerPresenterProtocol!
    let disposeBag = DisposeBag()
    let playerViewTapGesture = UITapGestureRecognizer()

    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        addPlayerViewTapGesture()
    }
    
    deinit {
        print("\(StreamContainerViewController.self) deinit")
    }
}

// MARK: - UI Setup
extension StreamContainerViewController {
    
    func setupUI() {
        addStreamViewController()
        setupStreamOverlayView()
    }
    
    func addStreamViewController() {
        presenter.addStream(to: view)
    }
    
    func setupStreamOverlayView() {
        view.bringSubviewToFront(streamOverlayView)
    }
}

// MARK: - Display
extension StreamContainerViewController {
    func showLoadingIndicator(isLoading: Bool) {
        isLoading ?
            streamOverlayView.activityIndicator.startAnimating() :
            streamOverlayView.activityIndicator.stopAnimating()
    }
    
    func addPlayerViewTapGesture() {
        view.addGestureRecognizer(playerViewTapGesture)
    }
}

extension StreamContainerViewController {
    
    func configureUIBinding() {
        bindCloseButtonTap()
        bindResizeButtonTap()
        bindPlayerViewTapGesture()
        bindShowingLoadingIndicatorWithPlayerState()
    }
    
    func bindCloseButtonTap() {
        streamOverlayView.closeButton.rx.tap
            .bind(to: presenter.viewModel.closeButtonDidTapped)
            .disposed(by: disposeBag)
    }
    
    func bindResizeButtonTap() {
        streamOverlayView.resizeButton.rx.tap
            .bind(to: presenter.viewModel.resizeButtonDidTapped)
            .disposed(by: disposeBag)
    }
    
    func bindPlayerViewTapGesture() {
        playerViewTapGesture.rx.event.bind(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.streamOverlayView.isHidden = !self.streamOverlayView.isHidden
        }).disposed(by: disposeBag)
    }
    
    func bindShowingLoadingIndicatorWithPlayerState() {
        presenter.viewModel.player.rx.timeControlStatus
            .observe(on: MainScheduler.instance)
            .map { [weak self] status -> Bool in
                guard let self = self,
                      let waitingReason = self.presenter.viewModel.player.reasonForWaitingToPlay
                else { return false }
                return status == .waitingToPlayAtSpecifiedRate && waitingReason != .noItemToPlay
            }
            .do(onNext: { [weak self] loading  in
                guard let self = self else {return}
                self.showLoadingIndicator(isLoading: loading)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
