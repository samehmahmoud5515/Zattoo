// 
//  SplashViewController.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit
import RxSwift
import RxCocoa

class SplashViewController: UIViewController, SplashViewControllerProtocol {
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Attributes
	var presenter: SplashPresenterProtocol!
    let disposeBag = DisposeBag()

    // MARK: -  View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

extension SplashViewController {
    func configureUIBinding() {
        bindActivityIndicator()
    }
    
    func bindActivityIndicator() {
        presenter.viewModel
            .isLoading
            .bind(to: activityIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
    }
}
