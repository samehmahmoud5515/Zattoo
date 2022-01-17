//
//  UIViewController+Present.swift
//  Zattoo
//
//  Created by SAMEH on 12/01/2022.
//

import UIKit

extension UIViewController {
    func add(child: UIViewController, to containerView: UIView, inset: UIEdgeInsets = .zero) {
        addChild(child)
        containerView.addSubview(child.view)
        child.view.translatesAutoresizingMaskIntoConstraints = false
        child.view.topAnchor.constraint(equalTo: containerView.topAnchor, constant: inset.top).isActive = true
        child.view.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: inset.bottom).isActive = true
        child.view.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: inset.left).isActive = true
        child.view.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: inset.right).isActive = true
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
    
    func presentOver(_ viewController: UIViewController, animated: Bool = false, completion:(() -> Void)? = nil) {
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        present(viewController, animated: animated, completion: completion)
    }
}
