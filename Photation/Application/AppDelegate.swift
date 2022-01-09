//
//  AppDelegate.swift
//  Photation
//
//  Created by Gleb Uvarkin on 30.06.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()

        return true
    }
}
