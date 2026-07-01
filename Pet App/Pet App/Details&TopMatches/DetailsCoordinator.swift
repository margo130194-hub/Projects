//
//  DetailsCoordinator.swift
//  Pet App
//
//  Created by Margarita Matsonko on 28/06/2026.
//

import UIKit

protocol DetailsCoordinatorProtocol: AnyObject{
    
}

final class DetailsCoordinator: Coordinator, DetailsCoordinatorProtocol{
   
    
    
    var navigationController: UINavigationController
    var childCoordinators: [Coordinator] = []
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
       
    }
    
    func openDetailPage(_ pet: RecommendedPets){
        let viewModel = DetailsViewModel(
            coordinator: self,
            pet: pet)
        let viewController = DetailsViewController(viewModel: viewModel)
        navigationController.pushViewController(viewController, animated: true)
        }
}

