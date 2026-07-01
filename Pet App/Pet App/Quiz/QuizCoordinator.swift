//
//  QuizCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 23/06/2026.
//

import UIKit

protocol QuizCoordinatorProtocol: AnyObject{
    func goToResultPage()
    
}

final class QuizCoordinator: Coordinator, QuizCoordinatorProtocol{
    
    var navigationController: UINavigationController
        var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    func start() {
        let viewModel = QuizViewModel(coordinator: self)
        let viewController = QuizViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func goToResultPage(){
        let resultViewModel = ResultViewModel()
        let resultVC = ResultViewController(viewModel: resultViewModel)
        navigationController.pushViewController(resultVC, animated: true)
    }
    
    }
