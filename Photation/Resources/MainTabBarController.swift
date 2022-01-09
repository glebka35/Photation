//
//  MainTabBarController.swift
//  Photation
//
//  Created by Gleb Uvarkin on 03.07.2020.
//  Copyright © 2020 Gleb Uvarkin. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let collectionVC = CollectionAssembly().createCollectionModule()

        let localizedString = LocalizedString()
        
        collectionVC.tabBarItem = UITabBarItem(title: localizedString.collection, image: UIImage(named: "collection"), tag: 0)
        
        let favoriteVC = FavoriteAssembly().createFavoriteModule()
        favoriteVC.tabBarItem = UITabBarItem(title: localizedString.favorite, image: UIImage(named: "favorite"), tag: 1)
        
        let imagePickerVC = ImagePickerAssembly().createImagePickerModule()
        imagePickerVC.tabBarItem = UITabBarItem(title: localizedString.add, image: UIImage(named: "camera"), tag: 2)
        
        let settingsVC = SettingsAssembly().createSettingsModule()
        settingsVC.tabBarItem = UITabBarItem(title: localizedString.settings, image: UIImage(named: "settings"), tag: 3)
        
        let tabBarList = [collectionVC, favoriteVC, imagePickerVC, settingsVC]
        
        viewControllers = tabBarList.map() {
            let controller = UINavigationController(rootViewController: $0)
            controller.setNavigationBarHidden(true, animated: false)
            return controller
        }
    }
}
