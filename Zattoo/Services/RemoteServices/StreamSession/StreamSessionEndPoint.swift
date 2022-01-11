//
//  StreamSessionEndPoint.swift
//  Zattoo
//
//  Created by SAMEH on 31/12/2021.
//

import Moya

enum StreamSessionEndPoint {
    case startSession
    case login
}

// MARK: - TargetType Protocol Implementation
extension StreamSessionEndPoint: TargetType, EnvironmentProtocol, DefaultHeadersProtocol, AccessTokenAuthorizable {
    
    var baseURL: URL {
        return apiBaseURL
    }
    
    var path: String {
        switch self {
        case .startSession:
            return "session/hello"
        case .login:
            return "v2/account/login"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .startSession:
            return .post
        case .login:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .startSession:
            var multiPart: [MultipartFormData] = []
            multiPart.append(MultipartFormData(provider: .data("8a302808-6433-4960-967c-920192a835be".data(using: .utf8) ?? Data()), name: "app_tid"))
            multiPart.append(MultipartFormData(provider: .data(UUID().uuidString.data(using: .utf8) ?? Data()), name: "uuid"))
            multiPart.append(MultipartFormData(provider: .data("en".data(using: .utf8) ?? Data()), name: "lang"))
            multiPart.append(MultipartFormData(provider: .data("json".data(using: .utf8) ?? Data()), name: "format"))
            return .uploadMultipart(multiPart)
        case .login:
            var multiPart: [MultipartFormData] = []
            multiPart.append(MultipartFormData(provider: .data("ply-challenge-apple@zattoo.com".data(using: .utf8) ?? Data()), name: "login"))
            multiPart.append(MultipartFormData(provider: .data("azwhjm6mwbm7u5HF".data(using: .utf8) ?? Data()), name: "password"))
            return .uploadMultipart(multiPart)
        }
    }
    
    var headers: [String: String]? { [:] }
    
    var authorizationType: AuthorizationType? { .none }
}
