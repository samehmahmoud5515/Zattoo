//
//  StreamSessionService.swift
//  Zattoo
//
//  Created by SAMEH on 31/12/2021.
//

import Moya
import RxSwift

class StreamSessionRemoteService: APIService<StreamSessionEndPoint>, StreamSessionRemoteServiceProtocol {
    func startSession() -> Single<SessionResponse> {
        return request(target: .startSession)
    }

    func login() -> Single<LoginResponse> {
        return request(target: .login)
    }
}
