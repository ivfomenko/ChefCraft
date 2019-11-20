//
//  AppDelegate.swift
//  ChefCraft
//
//  Created by Ivan Fomenko on 12.11.2019.
//  Copyright © 2019 Ivan Fomenko. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // MARK: - Properties
    var window: UIWindow?
    
    // MARK: - DependenciesHolder
    var dependenciesHolder: DependenciesHolder!
    
    // MARK: - application
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        self.setUpDefaultAppereance()
        
        self.dependenciesHolder = DependenciesHolder()
        let injector = dependenciesHolder.injector()
        let splashView = SplashBuilder.build(injector: injector)
        
        window?.rootViewController = UINavigationController(rootViewController: splashView)
        
        window?.makeKeyAndVisible()
        return true
    }
    
    private func setUpDefaultAppereance() {

        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().tintColor = .darkGreen
        UINavigationBar.appearance().backgroundColor = .clear
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.darkGreen,
            NSAttributedString.Key.font: UIFont(font: .metrapolisBold, size: 24.0)!
        ]

        UITabBar.appearance().layer.borderWidth = 0.0
        UITabBar.appearance().clipsToBounds = true
        
        let backImage = UIImage(named: "back")
        UINavigationBar.appearance().backIndicatorImage = backImage
        UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -80.0), for: .default)
        
        UITabBarItem.appearance().setTitleTextAttributes([
            NSAttributedString.Key.foregroundColor: UIColor.darkGreen,
            NSAttributedString.Key.font: UIFont(font: .metrapolisBold, size: 14.0)!],
                                                         for: .normal)
    }
}
