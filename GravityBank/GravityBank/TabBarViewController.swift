//
//  TabBarViewController.swift
//  GravityBank
//
//  Created by Margarita Matsonko on 04/04/2026.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Subviews
    
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    // MARK: - Layout
    
    private func setupTabBar() {
        let firstVC = MainViewController()
        let secondVC = SettingsViewController()
        
        let firstNav = UINavigationController(rootViewController: firstVC)
        let secondNav = UINavigationController(rootViewController: secondVC)
        
        firstNav.tabBarItem = UITabBarItem(
            title: "Home",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill"))
        
        secondNav.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill"))
        
        viewControllers = [firstNav, secondNav]
    }
    
}

