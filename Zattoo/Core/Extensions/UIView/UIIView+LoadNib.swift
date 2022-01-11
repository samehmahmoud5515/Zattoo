//
//  UIIView+LoadNib.swift
//  Zattoo
//
//  Created by SAMEH on 11/01/2022.
//

import UIKit

extension UIView {
    func loadNibFromFile() {
        let bundle = Bundle(for: type(of: self))
        guard let nibName = type(of: self).description().components(separatedBy: ".").last
        else { return }
        let nib = UINib(nibName: nibName, bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? UIView
        else { return }
        view.frame = bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(view)
    }
}
