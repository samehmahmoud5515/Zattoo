//
//  GradiantView.swift
//  Zattoo
//
//  Created by SAMEH on 17/01/2022.
//

import UIKit

@IBDesignable
class GradiantView: UIView {
    
    // MARK: - Private Attriutes
    private var fromColor: UIColor = .black30
    private var toColor: UIColor = .clear
    private var gradientDirection: GradientDirection = .bottomToTop
    
    // MARK: - Inspectable Attributes
    @IBInspectable
    var from: UIColor {
        set {
           fromColor = newValue
        }
        get {
            return fromColor
        }
    }
    
    @IBInspectable
    var to: UIColor {
        set {
            toColor = newValue
        }
        get {
            return toColor
        }
    }
    
    @IBInspectable
    var direction:Int {
        set {
            gradientDirection = GradientDirection(rawValue: newValue) ?? .bottomToTop
        }
        get {
            return gradientDirection.rawValue
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addGradientBackground()
    }
    
    func addGradientBackground() {
        gradientBackground(from: fromColor, to: toColor, direction: gradientDirection)
    }
}
