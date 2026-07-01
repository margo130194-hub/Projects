//
//  TabBarController.swift
//  Pet Advisor
//
//  Created by Margarita Matsonko on 09/04/2026.
//

import UIKit

final class TabBarViewController: UITabBarController {
    
    // MARK: - Subviews
    
    
    // MARK: - Lyfecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
    }
    
    //MARK: - Layout
    
    private func setupAppearance() {
        self.tabBar.tintColor = .darkBrown
        self.tabBar.unselectedItemTintColor = .darkBrown.withAlphaComponent(0.5)
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .beige
        self.tabBar.standardAppearance = appearance
      
    }
    
    
}
