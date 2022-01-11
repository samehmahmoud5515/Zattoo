//
//  UIView+Gradient.swift
//  Zattoo
//
//  Created by SAMEH on 01/01/2022.
//

import UIKit

enum GradientDirection: Int {
    case leftToRight = 0
    case rightToLeft = 1
    case bottomToTop = 2
    case topToBottom = 3
}

extension UIView {
    
    @discardableResult func gradientBackground(from color1: UIColor, to color2: UIColor, direction: GradientDirection) -> CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        let frame = CGRect(origin: bounds.origin, size: bounds.size)
        gradientLayer.frame = frame
        gradientLayer.colors = [color1.cgColor, color2.cgColor]

        switch direction {
        case .leftToRight:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        case .rightToLeft:
            gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.5)
        case .bottomToTop:
            gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        case .topToBottom:
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        }

        layer.insertSublayer(gradientLayer, at: 0)
        return gradientLayer
    }
}
