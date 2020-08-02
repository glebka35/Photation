//
//  AppDelegate.swift
//  VTB_project
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
        // Override point for customization after application launch.
        
        let frame = UIScreen.main.bounds
        window = UIWindow(frame: frame)
        
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()

        let _ = persistentContainer
        print(NSPersistentContainer.defaultDirectoryURL())

        return true
    }

//    MARK: - Core Data
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PhotationCoreData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Problem with NSPersistentContainer")
            }
        }
        return container
    } ()

}

