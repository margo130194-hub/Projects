//
//  DetailsViewModel.swift
//  Pet App
//
//  Created by Margarita Matsonko on 28/06/2026.
//

import Foundation

final class DetailsViewModel{
    
    weak var coordinator: DetailsCoordinator?
    
    let pet: RecommendedPets
    
    init(coordinator: DetailsCoordinator? = nil, pet: RecommendedPets) {
        self.coordinator = coordinator
        self.pet = pet
    }
    
    var name: String{
        pet.name
    }
    
    var imageName: String{
        pet.imageName
    }
    
    var description: String{
        pet.description
    }
    
    var information: [Info]{
        pet.information
    }
    
    var characteristic: [Characteristics]{
        pet.characteristics
    }
    
    var info: String{
        pet.info ?? ""
    }
}
    
