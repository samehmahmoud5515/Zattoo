//
//  GroupUIModel.swift
//  Zattoo
//
//  Created by SAMEH on 02/01/2022.
//

import RxSwift

// MARK: - GroupUIModel
struct GroupUIModel {
    var id: Int?
    var name: String?
    var groupType: GroupType = .other
}

enum GroupType {
    case all
    case other
}

extension GroupUIModel: Equatable {
    static func == (lhs: GroupUIModel, rhs: GroupUIModel) -> Bool {
        return lhs.id == rhs.id &&
            lhs.groupType == rhs.groupType
    }
}
