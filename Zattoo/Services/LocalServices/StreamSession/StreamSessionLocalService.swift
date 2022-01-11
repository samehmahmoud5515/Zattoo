//
//  StreamSessionLocalService.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

class StreamSessionLocalService: StreamSessionLocalServiceProtocol {
    func savePowerGuideHash(powerGuideHash: String) -> Single<()> {
        return Single<()>.create { single in
            
            Defaults[.powerGuideHash] = powerGuideHash
            
            single(.success(()))
            return Disposables.create()
        }
    }
    
    func retrievePowerGuideHash() -> Single<String> {
        guard let powerGuideHash = Defaults[.powerGuideHash] else {
            return Single.error(StreamSessionServiceError.powerGuideHashNotFound)
        }
        return Single.just(powerGuideHash)
    }
}
