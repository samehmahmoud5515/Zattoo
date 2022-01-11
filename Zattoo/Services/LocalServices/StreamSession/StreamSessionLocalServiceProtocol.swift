//
//  StreamSessionLocalServiceProtocol.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import RxSwift

protocol StreamSessionLocalServiceProtocol {
    func savePowerGuideHash(powerGuideHash: String) -> Single<()>
    func retrievePowerGuideHash() -> Single<String>
}
