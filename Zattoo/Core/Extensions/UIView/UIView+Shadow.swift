//
//  UIView+Shadow.swift
//  Zattoo
//
//  Created by SAMEH on 02/01/2022.
//

import UIKit

extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.3, radius: CGFloat = 1) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }

    func dropShadow(cornerRadius: CGFloat = 0, roundingCorners: UIRectCorner = .allCorners, color: UIColor, opacity: Float = 0.3, radius: CGFloat = 1, offset: CGSize = CGSize.zero) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: roundingCorners, cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)).cgPath
    }
}

