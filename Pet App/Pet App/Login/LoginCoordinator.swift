//
//  LoginCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject{
    func navigateToMainView()
    func navigateToSignUp()
    func navigateToReset()
    
}

final class LoginCoordinator: Coordinator, LoginCoordinatorProtocol{
    
    var navigationController: UINavigationController
        var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    func start(){
        let viewModel = LoginViewModel(coordinator: self)
        let viewController = LoginViewController(viewModel: viewModel)
        navigationController.setViewControllers([viewController], animated: true)
    }
    
    func navigateToMainView() {
        let tabBarCoordinator = TabBarCoordinator(navigationController: navigationController)
                childCoordinators.append(tabBarCoordinator)
                tabBarCoordinator.start()
    }
    
    func navigateToSignUp(){
        let signUpCoordinator = SignUpCoordinator(navigationController: navigationController)
                childCoordinators.append(signUpCoordinator)
                signUpCoordinator.start()
    }
    
    func navigateToReset() {
        navigationController.pushViewController(PasswordResetViewController(), animated: true)
    }
}
