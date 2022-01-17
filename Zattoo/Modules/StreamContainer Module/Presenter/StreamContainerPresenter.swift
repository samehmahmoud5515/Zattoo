// 
//  StreamContainerPresenter.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import RxSwift

class StreamContainerPresenter: StreamContainerPresenterProtocol {
    
    // MARK: - Attributes
    weak var viewController: StreamContainerViewControllerProtocol?
    let interactor: StreamContainerInteractorProtocol
    let router: StreamContainerRouterProtocol
    let viewModel: StreamContainerViewModel
    let disposeBag = DisposeBag()

    // MARK: - init
    init(
        viewController: StreamContainerViewControllerProtocol,
        interactor: StreamContainerInteractorProtocol,
        router: StreamContainerRouterProtocol,
        viewModel: StreamContainerViewModel) {
        self.viewController = viewController
        self.interactor = interactor
        self.router = router
        self.viewModel = viewModel
    }
    
    // MARK: - Life Cycle
    func viewDidLoad() {
        addStreamView()
        bindPlayerActions()
        viewController?.setupUI()
        viewController?.configureUIBinding()
        bindCurrentResolutionItemQuality()
    }
    
    // MARK: - Methods
    func addStreamView() {
        router.go(to: .stream(
                    channelStream: viewModel.channelStream,
                    player: viewModel.player,
                    videoGravity: viewModel.videoGravity))
    }
    
    func bindPlayerActions() {
        viewModel.closeButtonDidTapped.bind { [weak self] action in
            self?.router.go(to: .close)
        }.disposed(by: disposeBag)
        
        viewModel.settingsButtonDidTapped.bind { [weak self] action in
            guard let player = self?.viewModel.player else { return }
            self?.router.go(to: .streamSetting(player: player))
        }.disposed(by: disposeBag)
    }
    
    private func bindCurrentResolutionItemQuality() {
        let preferredMaximumResolution = viewModel.player.rx.currentItem
            .compactMap { $0 }
            .flatMap { $0.rx.preferredMaximumResolution }
        
        let presentationSize = viewModel.player.rx.currentItem
            .compactMap { $0 }
            .flatMap { $0.rx.presentationSize }
        
        return Observable.combineLatest(preferredMaximumResolution, presentationSize)
            .filter { [weak self] _ in
                guard let self = self else { return false}
                guard let reasonForWaitingToPlay = self.viewModel.player.reasonForWaitingToPlay, self.viewModel.player.status == .readyToPlay else { return true }
                return  reasonForWaitingToPlay != .noItemToPlay
            }
            .map { [weak self] preferredMaximumResolution, presentationSize in
                let maxResolution = Int(preferredMaximumResolution.height)
                let presentationSizeResolution = Int(presentationSize.height)
                var quality: VideoQuality {
                    if maxResolution > 0 {
                        return VideoQuality(resolution: maxResolution)
                    } else {
                        return .auto
                    }
                }
                if quality == .auto && presentationSizeResolution > 0 {
                    self?.viewModel.currentResolution.accept("Auto(\(presentationSizeResolution))")
                } else if quality.heightResolution > 0 {
                    self?.viewModel.currentResolution.accept("\(quality.heightResolution)")
                }
            }
            .subscribe()
            .disposed(by: disposeBag)
    }
}
