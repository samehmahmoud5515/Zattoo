//
//  EnvironmentProtocol.swift
//  Zattoo
//
//  Created by SAMEH on 31/12/2021.
//

import Foundation

protocol EnvironmentProtocol {
    var current: Environment { get }
    
    // MARK: - Domain
    var serverMainDomain: String { get }
    var apiDomain: String { get }
   
    // MARK: - URL
    var apiBaseURL: URL { get }
}

extension EnvironmentProtocol {
    public var current: Environment {
        return Environment.current
    }
   
    // MARK: - Domain
    public var serverMainDomain: String {
        return Environment.current.serverMainDomain
    }
    
    public var apiDomain: String {
        return Environment.current.apiDomain
    }
   
    // MARK: - URL
    public var apiBaseURL: URL {
        return URL(string: Environment.current.baseURL)!
    }
}
