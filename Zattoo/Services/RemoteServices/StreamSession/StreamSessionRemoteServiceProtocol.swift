//
//  StreamSessionServiceProtocol.swift
//  Zattoo
//
//  Created by SAMEH on 31/12/2021.
//

import RxSwift

protocol StreamSessionRemoteServiceProtocol {
    func startSession() -> Single<SessionResponse>
    func login() -> Single<LoginResponse>
}
