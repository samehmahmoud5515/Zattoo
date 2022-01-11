//
//  AppDelegate.swift
//  Zattoo
//
//  Created by SAMEH on 25/12/2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Attributes
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        configureRootViewController()
        
        return true
    }
    
    func configureRootViewController() {
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = SplashRouter.assembleModule()
        let navigationViewController = UINavigationController(rootViewController: rootViewController)
        navigationViewController.isNavigationBarHidden = true
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
    }
}

