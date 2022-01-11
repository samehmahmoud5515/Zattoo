// 
//  StreamViewController.swift
//  Zattoo
//
//  Created by SAMEH on 03/01/2022.
//

import UIKit
import RxSwift
import RxCocoa
import AVFoundation

class StreamViewController: UIViewController, StreamViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var playerView: PlayerView!
    @IBOutlet weak var overlayView: StreamOverlayView!
    
    // MARK: - Attributes
	var presenter: StreamPresenterProtocol!
    let disposeBag = DisposeBag()
    let player = AVPlayer()
    let playerViewTapGesture = UITapGestureRecognizer()

    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
}

// MARK: - Setup UI
extension StreamViewController {
    func setupUI() {
        setupPlayer()
        addPlayerViewTapGesture()
    }
    
    func setupPlayer() {
        playerView.playerLayer.player = player
        playerView.playerLayer.videoGravity = .resizeAspect
        
        guard
            let url = presenter.viewModel.channelStream.url,
            let videoURL = URL(string: url)
        else { return }
        
        let videoAsset = AVURLAsset(url: videoURL)
        let playerItem = AVPlayerItem(asset: videoAsset)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
    
    func addPlayerViewTapGesture() {
        playerView.addGestureRecognizer(playerViewTapGesture)
    }
    
    func showLoadingIndicator(isLoading: Bool) {
        isLoading ?
            overlayView.activityIndicator.startAnimating() :
            overlayView.activityIndicator.stopAnimating()
    }
}

// MARK: - UI Binding
extension StreamViewController {
    func configureUIBinding() {
        bindCloseButtonTap()
        bindResizeButtonTap()
        bindPlayerViewTapGesture()
        bindPlayerGravityWithVideoGravity()
        bindShowingLoadingIndicatorWithPlayerState()
    }
    
    func bindCloseButtonTap() {
        overlayView.closeButton.rx.tap
            .bind(to: presenter.viewModel.closeButtonDidTapped)
            .disposed(by: disposeBag)
    }
    
    func bindResizeButtonTap() {
        overlayView.resizeButton.rx.tap
            .bind(to: presenter.viewModel.resizeButtonDidTapped)
            .disposed(by: disposeBag)
    }
    
    func bindPlayerViewTapGesture() {
        playerViewTapGesture.rx.event.bind(onNext: { [weak self] _ in
            guard let self = self else { return }
            self.overlayView.isHidden = !self.overlayView.isHidden
        }).disposed(by: disposeBag)
    }
    
    func bindPlayerGravityWithVideoGravity() {
        presenter.viewModel.videoGravity
            .observe(on: MainScheduler.instance)
            .bind { [weak self] gravity in
                self?.playerView.playerLayer.videoGravity = gravity
            }.disposed(by: disposeBag)
    }
    
    func bindShowingLoadingIndicatorWithPlayerState() {
        player.rx.timeControlStatus
            .observe(on: MainScheduler.instance)
            .map { [weak self] status -> Bool in
                guard let self = self,
                      let waitingReason = self.player.reasonForWaitingToPlay
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
