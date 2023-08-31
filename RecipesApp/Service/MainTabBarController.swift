//
//  MainTabBarController.swift
//  RecipesApp
//
//  Created by Владислав on 27.08.2023.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBar()
        setupItems()
    }
    
    private func setupTabBar() {
        tabBar.backgroundColor = .neutral0
        tabBar.tintColor = .primary50
        tabBar.unselectedItemTintColor = .neutral50
    }
    
    private func setupItems() {
        
        let home = HomeViewController()
        let discover = DiscoverViewController()
        let notification = UIViewController()
        let profile = SeeAllViewController()

        setViewControllers([home, discover, notification, profile], animated: true)
        
        guard let items = tabBar.items else { return }
        
        items[0].image = UIImage(named: "home")
        items[1].image = UIImage(named: "inactive")
        items[2].image = UIImage(named: "notification")
        items[3].image = UIImage(named: "profile")
    }
}
