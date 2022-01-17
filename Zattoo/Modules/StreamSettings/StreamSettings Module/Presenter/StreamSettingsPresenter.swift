// 
//  StreamSettingsPresenter.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import RxSwift
import AVFoundation

class StreamSettingsPresenter: StreamSettingsPresenterProtocol {
    
    // MARK: - Attributes
    weak var viewController: StreamSettingsViewControllerProtocol?
    let interactor: StreamSettingsInteractorProtocol
    let router: StreamSettingsRouterProtocol
    let viewModel: StreamSettingsViewModel
    let disposeBag = DisposeBag()

    // MARK: - init
    init(
        viewController: StreamSettingsViewControllerProtocol,
        interactor: StreamSettingsInteractorProtocol,
        router: StreamSettingsRouterProtocol,
        viewModel: StreamSettingsViewModel) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
        self.viewModel = viewModel
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        viewController?.setupUI()
        viewController?.configureUIBinding()
        bindCloseButtonDidTapped()
        populateDataSourceWithTracks()
    }
    
    func bindCloseButtonDidTapped() {
        viewModel.cancelButtonDidTapped.bind { [weak self] _ in
            self?.router.go(to: .close)
        }.disposed(by: disposeBag)
    }

    
    // MARK: - Methods
    func populateDataSourceWithTracks() {
        let audioTrack = getPlayerSettingsUIModel(type: .audio)
            .startWith(.audio(.none, false))
        let subtitleTrack = getPlayerSettingsUIModel(type: .subtitle)
            .startWith(.subtitle(.none, false))
        let selectedVideoQuality = getVideoTrackQuality()

        Observable.combineLatest([audioTrack, selectedVideoQuality, subtitleTrack])
            .do(onNext: { [weak self] settings in
                guard let self = self else { return }
                self.viewModel.dataSource.accept(settings)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    func getVideoTrackQuality() -> Observable<PlayerSettingsUIModel> {
        
        let preferredMaximumResolution = viewModel.player.rx.currentItem
            .compactMap { $0 }
            .flatMap { $0.rx.preferredMaximumResolution}
        
        let presentationSize =  viewModel.player.rx.currentItem
            .compactMap {$0}
            .flatMap { $0.rx.presentationSize}
        
        return Observable.combineLatest(preferredMaximumResolution, presentationSize)
            .filter {[weak self] _ in
                guard let self = self else { return false }
                guard let reasonForWaitingToPlay = self.viewModel.player.reasonForWaitingToPlay, self.viewModel.player.status == .readyToPlay else { return true }
                return  reasonForWaitingToPlay != .noItemToPlay
            }
            .flatMap { preferredMaximumResolution, presentationSize -> Observable<PlayerSettingsUIModel> in
                let maxResolution = Int(preferredMaximumResolution.height)
                var quality: VideoQuality {
                    if maxResolution > 0 {
                        return VideoQuality(resolution: maxResolution)
                    } else {
                        return .auto
                    }
                }
                return Observable.just(.quality(quality, quality.heightResolution, true))
            }
    }
    
    func getPlayerSettingsUIModel(type: AVPlayerItem.TrackType) -> Observable<PlayerSettingsUIModel> {
        return
            Observable.zip(
                shouldEnableTrackSelection(type:  type),
                getSelectTrack(type: type)
            )
            .flatMap { enable, name -> Observable<PlayerSettingsUIModel> in
                switch type {
                case .audio: return Observable.just(.audio(name, enable))
                case .subtitle: return Observable.just(.subtitle(name, enable))
                default: return Observable.empty()
                }
            }
    }
    
    func shouldEnableTrackSelection(type: AVPlayerItem.TrackType) -> Observable<Bool> {
        return viewModel.player.rx.currentItem
            .compactMap { $0 }
            .flatMap { $0.rx.tracks(type: type) }
            .map { $0.count > 0 }
    }
    
    func getSelectTrack(type: AVPlayerItem.TrackType) -> Observable<Option<String>> {
        viewModel.player.rx.currentItem
            .compactMap { $0 }
            .flatMap { $0.rx.selectedTrack(type: type) }
            .compactMap { $0 == nil ? "" : $0 }
            .map { !$0.isEmpty ? .value($0) : .none }
    }
    
    func navigateToSettingsSelections(setting: PlayerSettingsUIModel) {
        router.go(to: .options(setting: setting, player: viewModel.player))
    }
}
