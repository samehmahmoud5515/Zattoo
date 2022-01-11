//
//  Environment.swift
//  Zattoo
//
//  Created by SAMEH on 31/12/2021.
//

import Foundation

public enum Environment: String {
    case sandBox  = "DEVELOPMENT"
    case production = "PRODUCTION"
    
    // MARK: - Current Environment
    static var current: Environment {
        let env = UserDefaults.standard.value(forKey: "CurrentEnvironment") as? String
        return Environment(rawValue: env ?? "") ?? .sandBox
    }
    
    // MARK: - Domain
    var serverMainDomain: String {
        switch self {
        case .sandBox:
            return "sandbox.zattoo.com"
        case .production:
            return "sandbox.zattoo.com"
        }
    }

    var apiDomain: String {
        switch self {
        case .sandBox:
            return "\(serverMainDomain)/zapi/"
        case .production:
            return "\(serverMainDomain)/zapi/"
        }
    }
    // MARK: - URL
    var baseURL: String {
        return "https://\(apiDomain)"
    }
}
