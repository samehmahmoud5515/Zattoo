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
    
    // MARK: - Attributes
	var presenter: StreamPresenterProtocol!
    let disposeBag = DisposeBag()
    weak var player: AVPlayer?

    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    deinit {
        print("\(StreamViewController.self) deinit")
    }
}

// MARK: - Setup UI
extension StreamViewController {
    func setupUI() {
        setupPlayer()
    }
    
    func setupPlayer() {
        guard let player = player else { return }
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
}

// MARK: - setup AVAudioSession
extension StreamViewController {
    func setupAVAudioSession() {
        do {
            let audioSession = AVAudioSession.sharedInstance()
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try audioSession.setCategory(.playback)
        }
        catch {}
    }
}

// MARK: - UI Binding
extension StreamViewController {
    func configureUIBinding() {
        bindPlayerGravityWithVideoGravity()
        bindPlayerMutedWithOutputVolume()
    }
    
    func bindPlayerGravityWithVideoGravity() {
        presenter.viewModel.videoGravity
            .observe(on: MainScheduler.instance)
            .bind { [weak self] gravity in
                self?.playerView.playerLayer.videoGravity = gravity
            }.disposed(by: disposeBag)
    }
    
    func bindPlayerMutedWithOutputVolume() {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        audioSession.rx.outputVolume
            .startWith(audioSession.outputVolume)
            .map { $0 == 0.0 }
            .do(onNext: { [weak self] mute in
                guard let self = self else {return}
                self.player?.isMuted = mute
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
}
