//
//  Option.swift
//  Zattoo
//
//  Created by SAMEH on 17/01/2022.
//

import Foundation

enum Option<T: Equatable> {
    case value(_ value: T)
    case none
}

extension Option: Equatable {
    static func == (lhs: Option, rhs: Option) -> Bool {
        switch (lhs, rhs) {
        case let (.value(lhsValue), .value(rhsValue)):
            return lhsValue == rhsValue
        case (.none, .none): return true
        default:
            return false
        }
    }
}

extension Option {
    var value: String? {
        switch self {
        case let .value(stringValue):
            return "\(stringValue)"
        case .none:
            return "None"
        }
    }
}
