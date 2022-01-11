//
//  DefaultHeadersProtocol.swift
//  Zattoo
//
//  Created by SAMEH on 31/12/2021.
//

import Foundation

protocol DefaultHeadersProtocol {
    var defaultHeader: [String: String] { get }
}

extension DefaultHeadersProtocol {
    var defaultHeader: [String: String] {
        var header = [String: String]()
        header.updateValue("application/x-www-form-urlencoded", forKey: "Content-Type")
        return header
    }
}
