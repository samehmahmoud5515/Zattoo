// 
//  SplashInteractor.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

class SplashInteractor: SplashInteractorProtocol {
    // MARK: - Attributes
    let sessionRemoteService: StreamSessionRemoteServiceProtocol
    let sessionlocalService: StreamSessionLocalServiceProtocol
    
    // MARK: - init
    init(sessionRemoteService: StreamSessionRemoteServiceProtocol,
         sessionlocalService: StreamSessionLocalServiceProtocol) {
        self.sessionRemoteService = sessionRemoteService
        self.sessionlocalService = sessionlocalService
    }
    
    // MARK: - Methods
    func startSession() -> Observable<Session> {
        return sessionRemoteService.startSession()
            .asObservable()
            .flatMap { response -> Observable<Session> in
                if response.success ?? false, let session = response.session {
                    return Observable.just(session)
                } else {
                    return Observable.error(StreamSessionServiceError.businessError)
                }
            }
    }
    
    func login() -> Observable<LoginSession> {
        return sessionRemoteService.login()
            .asObservable()
            .flatMap { response -> Observable<LoginSession> in
                if response.success ?? false, let session = response.session {
                    return Observable.just(session)
                } else {
                    return Observable.error(StreamSessionServiceError.businessError)
                }
            }
    }
    
    func save(powerGuideHash: String) -> Observable<()> {
        return sessionlocalService
            .savePowerGuideHash(powerGuideHash: powerGuideHash)
            .asObservable()
    }
}
