//
//  UILabel+Extensions.swift
//  Zattoo
//
//  Created by SAMEH on 18/01/2022.
//

import UIKit

extension UILabel {
    func setAttributedTextWithSubscripts(text: String, indicesOfSubscripts: [Int], color: UIColor) {
        let font = self.font ?? UIFont.systemFont(ofSize: 14)
        let subscriptFont = font.withSize(font.pointSize * 0.7)
        let subscriptOffset = font.pointSize * 0.3
        let attributedString = NSMutableAttributedString(string: text,
                                                         attributes: [.font : font])
        for index in indicesOfSubscripts {
            let range = NSRange(location: index, length: 1)
            attributedString.setAttributes([.font: subscriptFont,
                                            .baselineOffset: subscriptOffset,
                                            .foregroundColor: color],
                                           range: range)
        }
        self.attributedText = attributedString
    }
}
