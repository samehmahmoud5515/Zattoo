//
//  ChannelsEndPoint.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Moya

enum ChannelsEndPoint {
    case getChannels(powerGuideHash: String)
    case getChannelStreamURL(channelId: String)
}

// MARK: - TargetType Protocol Implementation
extension ChannelsEndPoint: TargetType, EnvironmentProtocol, DefaultHeadersProtocol, AccessTokenAuthorizable {
    
    var baseURL: URL {
        return apiBaseURL
    }
    
    var path: String {
        switch self {
        case let .getChannels(powerGuideHash):
            return "v4/cached/\(powerGuideHash)/channels"
        case let .getChannelStreamURL(channelId):
            return "watch/live/\(channelId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getChannels:
            return .get
        case .getChannelStreamURL:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getChannels:
            return .requestPlain
        case .getChannelStreamURL:
            var paramters = [String: Any]()
            paramters.updateValue("hls7", forKey: "stream_type")
            return .requestParameters(parameters: paramters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? { defaultHeader }
    
    var authorizationType: AuthorizationType? { .none }
}
