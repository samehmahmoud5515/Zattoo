// 
//  StreamSettingsOptionsPresenter.swift
//  Zattoo
//
//  Created by SAMEH on 15/01/2022.
//

import UIKit
import RxSwift

class StreamSettingsOptionsPresenter: StreamSettingsOptionsPresenterProtocol {
    
    // MARK: - Attributes
    weak var viewController: StreamSettingsOptionsViewControllerProtocol?
    let interactor: StreamSettingsOptionsInteractorProtocol
    let router: StreamSettingsOptionsRouterProtocol
    let viewModel: StreamSettingsOptionsViewModel
    let disposeBag = DisposeBag()

    // MARK: - init
    init(
        viewController: StreamSettingsOptionsViewControllerProtocol,
        interactor: StreamSettingsOptionsInteractorProtocol,
        router: StreamSettingsOptionsRouterProtocol,
        viewModel: StreamSettingsOptionsViewModel) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
        self.viewModel = viewModel
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        viewController?.setupUI()
        viewController?.configureUIBinding()
        populateTableViewDataSource()
    }
    
    // MARK: - Methods
    private func populateTableViewDataSource(){
        switch viewModel.setting {
        case .quality:
            getQuailtyOptions()
        case .audio:
            getAudioOptions()
        case .subtitle:
            getSubtitleOptions()
        }
    }
    
    private func getQuailtyOptions(){
        
        let filterdQualities: [PlayerSettingsUIModel] =
            VideoQuality.allCases
            .sorted(by: {$0.qualityOrder < $1.qualityOrder})
            .map { [weak self] quality in
                var playerSettingsUIModel =
                    PlayerSettingsUIModel.quality(quality, quality.heightResolution, false)
                if self?.viewModel.setting == playerSettingsUIModel {
                    playerSettingsUIModel.enableSetting()
                }
                return playerSettingsUIModel
            }
        
        viewModel.settingsDataSource.accept(filterdQualities)
    }
    
    private func getAudioOptions(){
        viewModel.player.rx.currentItem
            .compactMap { $0 }
            .flatMap { $0.rx.tracks(type: .audio) }
            .do(onNext: {[weak self] (audioTracks) in
                var settingsDataSource = [PlayerSettingsUIModel]()
                for track in audioTracks {
                    let track = PlayerSettingsUIModel.audio(.value(track), false)
                    settingsDataSource.append(track)
                }
                self?.enableSelectedSetting(&settingsDataSource)
                self?.viewModel.settingsDataSource.accept(settingsDataSource)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func getSubtitleOptions(){
        viewModel.player.rx.currentItem
            .compactMap {$0}
            .flatMap{ $0.rx.tracks(type: .subtitle) }
            .do(onNext:{ [weak self] subtitles in
                var settingsDataSource = [PlayerSettingsUIModel]()
                for subtitle in subtitles{
                    let track = PlayerSettingsUIModel.subtitle(.value(subtitle), false)
                    settingsDataSource.append(track)
                }
                self?.enableSelectedSetting(&settingsDataSource)
                self?.viewModel.settingsDataSource.accept(settingsDataSource)
            })
            .subscribe()
            .disposed(by: disposeBag)
    }
    
    private func enableSelectedSetting(_ settingsDataSource: inout [PlayerSettingsUIModel]) {
        settingsDataSource = settingsDataSource.map { [weak self] (playerSettingsUIModel) -> PlayerSettingsUIModel in
            var adjustedModel = playerSettingsUIModel
            if adjustedModel == self?.viewModel.setting {
                adjustedModel.enableSetting()
            }
            return adjustedModel
        }
    }
}

//MARK: - selection
extension StreamSettingsOptionsPresenter {
        
    func didSelectOption(option: PlayerSettingsUIModel) {
        switch option {
        case let .quality(quality, resolution, _):
            handleQualitySelection(quality: quality,resolution: resolution)
        case .subtitle(let subtitleOptionValue, _):
            handleSubtitleSelection(subtitleOption: subtitleOptionValue)
        case .audio(let audioOptionValue, _):
            handleAudioSelection(audioOption: audioOptionValue)
        }
        router.go(to: .dismiss)
    }
    
    private func handleQualitySelection(quality: VideoQuality,resolution: Int) {
        
        let playerItem = self.viewModel.player.currentItem
        
        if quality == .auto {
            playerItem?.preferredMaximumResolution = .zero
        } else {
            playerItem?.preferredMaximumResolution = .init(width: quality.widthResolution, height: quality.heightResolution)
        }
    }
    
    private func handleAudioSelection(audioOption: Option<String>){
        guard case let .value(audioOption) = audioOption else {return}
        viewModel.player.currentItem?.selectTrack(type: .audio, name: audioOption)
    }
    
    private func handleSubtitleSelection(subtitleOption: Option<String>){
        guard case let Option.value(subtitleOption) = subtitleOption else {return}
        viewModel.player.currentItem?.selectTrack(type: .subtitle, name: subtitleOption)
    }
}
