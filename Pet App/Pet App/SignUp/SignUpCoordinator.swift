//
//  SignUpCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit

protocol SignUpCoordinatorProtocol: AnyObject{
    func navigateToLogIn()
}

final class SignUpCoordinator: Coordinator, SignUpCoordinatorProtocol{
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        
    }
    func start(){
        let viewModel = SignUpViewModel(coordinator: self)
        let viewController = SignUpViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func navigateToLogIn() {
        navigationController.popViewController(animated: true)
    }
}
