//
//  AppCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit
import FirebaseAuth

final class AppCoordinator: Coordinator{
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    private let window: UIWindow
    
    init(navigationController: UINavigationController, window: UIWindow) {
        self.navigationController = navigationController
        self.window = window
    }
    
    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
                let hasSeenOnbording = UserDefaults.standard.bool(forKey: "hasSeenOnboarding")
                if hasSeenOnbording{
                    if Auth.auth().currentUser != nil{
                        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
                            childCoordinators.append(tabBarCoordinator)
                                        tabBarCoordinator.start()
                    } else {
                        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
                                       childCoordinators.append(loginCoordinator)
                                       loginCoordinator.start()
                    }
                } else {
                    let onboardingVC = ContainerCoordinator(navigationController: navigationController)
                    childCoordinators.append(onboardingVC)
                    onboardingVC.start()
                }
    }
    
}
