//
//  LoginResponse.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - LoginResponse
struct LoginResponse: Codable {
    var session: LoginSession?
    var success: Bool?
}
