//
//  Group.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import Foundation

// MARK: - Group
struct Group: Codable {
    var id: Int?
    var name: String?
}

extension Group: Equatable { }
