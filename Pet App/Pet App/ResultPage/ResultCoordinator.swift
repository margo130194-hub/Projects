//
//  ResultCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 25/06/2026.
//

import UIKit

protocol ResultCoordinatorProtocol: AnyObject{
    func openDetailPage(_ pet: RecommendedPets)
    func goToMatches(_ pets: RecommendedPets)
}

final class ResultCoordinator: Coordinator, ResultCoordinatorProtocol{
   
    
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = ResultViewModel(coordinator: self)
        let viewController = ResultViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func openDetailPage(_ pet: RecommendedPets){
        let viewModel = DetailsViewModel(pet: pet)
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        }
    
    func goToMatches(_ pets: RecommendedPets){
        
    }
}
