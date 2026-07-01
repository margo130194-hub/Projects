//
//  ContainerCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit

protocol ContainerCoordinatorProtocol: AnyObject {
    func goToLogin()
}

final class ContainerCoordinator: Coordinator, ContainerCoordinatorProtocol{
    var navigationController: UINavigationController
    var childCoordinators: [any Coordinator] = []
    
    init(navigationController: UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let onboardingVC = ContainerViewController(coordinator: self)
        navigationController.setViewControllers([onboardingVC], animated: true)
    }
    
    func goToLogin() {
        UserDefaults.standard.set(true, forKey: "hasSeenOnboarding")
        let loginCoordinator = LoginCoordinator(navigationController: navigationController)
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
    }
}

