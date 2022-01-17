// 
//  StreamContainerViewController.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class StreamContainerViewController: UIViewController, StreamContainerViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var streamOverlayView: StreamControlsView!
    @IBOutlet weak var streamOverlayContainerView: UIView!
    
    // MARK: - Attributes
	var presenter: StreamContainerPresenterProtocol!
    let disposeBag = DisposeBag()
    let viewTapGesture = UITapGestureRecognizer()

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
        setupStreamOverlayView()
    }
    
    func setupStreamOverlayView() {
        view.bringSubviewToFront(streamOverlayContainerView)
    }
}

// MARK: -
extension StreamContainerViewController {
    func showLoadingIndicator(isLoading: Bool) {
        isLoading ?
            streamOverlayView.activityIndicator.startAnimating() :
            streamOverlayView.activityIndicator.stopAnimating()
    }
    
    func addPlayerViewTapGesture() {
        streamOverlayContainerView.addGestureRecognizer(viewTapGesture)
    }
}

// MARK: - UIBinding
extension StreamContainerViewController {
    
    func configureUIBinding() {
        bindCloseButtonTap()
        bindResizeButtonTap()
        bindSettingsButtonTap()
        bindPlayerViewTapGesture()
        bindShowingLoadingIndicatorWithPlayerState()
        bindBitRateLabelText()
        bindCurrentPlaybackPositionLabelText()
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
    
    func bindSettingsButtonTap() {
        streamOverlayView.settingsButton.rx.tap
            .bind(to: presenter.viewModel.settingsButtonDidTapped)
            .disposed(by: disposeBag)
    }
    
    func bindPlayerViewTapGesture() {
        viewTapGesture.rx.event
            .bind(onNext: { [weak self] _ in
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
    
    func bindBitRateLabelText() {
        presenter.viewModel.currentResolution
            .bind(to: streamOverlayView.bitRateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindCurrentPlaybackPositionLabelText() {
        let player = presenter.viewModel.player
        player.rx
            .periodicTimeObserver(timeInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: DispatchQueue.main)
            .flatMap { _ in player.rx.currentItem }
            .filter { $0?.status == .readyToPlay }
            .compactMap { $0?.currentTime() }
            .bind { [weak self] currentTime in
                let currentTimeInSeconds = Int(CMTimeGetSeconds(currentTime))
                let formatedTime = String(format: "%02d:%02d", currentTimeInSeconds / 60, currentTimeInSeconds % 60 )
                self?.streamOverlayView.currentPlaybackPositionLabel.text = formatedTime
            }.disposed(by: disposeBag)
    }
}
