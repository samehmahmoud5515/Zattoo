// 
//  SplashViewModel.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

struct SplashViewModel {
    
    let localization = SplashLocalization()
    let isLoading = PublishSubject<Bool>()
}
