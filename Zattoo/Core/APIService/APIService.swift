//
//  APIService.swift
//  Zattoo
//
//  Created by SAMEH on 25/12/2021.
//

import Moya
import RxSwift

class APIService<T> where T:TargetType, T:AccessTokenAuthorizable {
    
    // MARK: - Attributes
    private let provider: MoyaProvider<T>
    
    private let jsonDataFormatter = { (_ data: Data) -> String  in
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            let prettyData = try JSONSerialization.data(withJSONObject: dataAsJSON, options: .prettyPrinted)
            return String(data: prettyData, encoding: .utf8) ?? ""
        } catch {
            return String(data: data, encoding: .utf8) ?? ""
        }
    }
    
    private let endpointClosure = { (target: T) -> Endpoint in
        var defaultEndpoint = MoyaProvider.defaultEndpointMapping(for: target)
    
        var addtionHeader = target.authentications
        defaultEndpoint = defaultEndpoint.adding(newHTTPHeaderFields: addtionHeader)
        
        var request = try? defaultEndpoint.urlRequest()
        request?.cachePolicy = .useProtocolCachePolicy
        return defaultEndpoint
   }
    
    // MARK: - Init
    init() {
        provider = MoyaProvider<T>(endpointClosure: endpointClosure,
                                   session: Moya.Session.default,
                                   plugins: [NetworkLoggerPlugin(configuration: .init(formatter: .init( requestData: jsonDataFormatter, responseData: jsonDataFormatter), logOptions: .verbose))])
    }
        
    // MARK: - Methods
    func request<R: Codable>(target: T) -> Single<R> {
        return provider.rx.request(target)
            .map(R.self)
    }
}

extension AccessTokenAuthorizable {
    var authentications:[String: String] {
        switch authorizationType {
        case .custom:
            return [:]
        case .none:
            return [:]
        case .basic:
            return ["Authorization": "Basic aW9zOmlvc1BBYXNzd2Q="]
        case .bearer:
            return [:]
            //return  ["Authorization": "Bearer \(Defaults[.acessToken] ?? "")"]
        }
    }
}
