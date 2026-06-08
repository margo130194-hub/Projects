//
//  TabBarViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/04/2026.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        iconColor()
    }
    
    // MARK: - Layout
    private func setupTabBar() {
        let firstVC = MainViewController.build()
        let secondVC = SettingsViewController.build()
        let thirdVC = MapViewController.build()
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        let thirdNav = UINavigationController(rootViewController: thirdVC)
        
        firstNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        
        secondNav.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill"))
        
        thirdNav.tabBarItem = UITabBarItem(
            title: "Map",
            image: UIImage(systemName: "map"),
            selectedImage: UIImage(systemName: "map.fill"))
        
        viewControllers = [firstNav, secondNav, thirdNav]
    }
    private func iconColor(){
        self.tabBar.tintColor = UIColor(named: "GravityColor")
        self.tabBar.unselectedItemTintColor = .systemGray
    }
}

