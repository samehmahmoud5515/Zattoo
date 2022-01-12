//
//  UIViewController+Present.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import UIKit

extension UIViewController {
    func add(child: UIViewController, to containerView: UIView) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor).isActive = true
        child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor).isActive = true
        child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor).isActive = true
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }
        willMove(toParent: nil)
        removeFromParent()
        view.removeFromSuperview()
    }
}
