//
//  ResultViewModel.swift
//  Pet App
//
//  Created by Margarita Matsonko on 25/06/2026.
//

import Foundation

final class ResultViewModel{
    
    weak var coordinator: ResultCoordinator?
    
    init(coordinator: ResultCoordinator? = nil) {
        self.coordinator = coordinator
    }
    let recommendedPets = Bindable<[RecommendedPets]>([])
    
    func updateResult() {
        guard let answers = UserDefaults.standard.array(forKey: "userAnswers") as? [Int], answers.count == 11 else {return}
        do{
            var allPets:[RecommendedPets] = []
            let fileNames = ["Cats", "Dogs", "Parrots", "Pets"]
            for fileName in fileNames {
                let fetchedList:[RecommendedPets] = try JsonService.shared.fetchData(fileName: fileName)
                allPets.append(contentsOf: fetchedList)
            }
            let scoredPets: [(pet: RecommendedPets, score: Int)] = allPets.map { pet in
                var score = 0
                switch answers[0] {
                case 0:
                    if pet.apartmentFriendly == true || pet.housing == .apartment {
                        score += 3
                    } else {
                        score -= 2
                    }
                case 1:
                    if pet.apartmentFriendly == false || pet.housing == .house{
                        score += 3
                    } else {
                        score += 1
                    }
                default:
                    break
                }
                
                switch answers[1] {
                case 0:
                    score += 1
                case 1:
                    if pet.aloneTime == .medium || pet.aloneTime == .high {
                        score += 2
                    } else {
                        score -= 1
                    }
                case 2:
                    if pet.aloneTime == .high {
                        score += 3
                    } else if pet.aloneTime == .medium {
                        score += 1
                    } else {
                        score -= 2
                    }
                default:
                    break
                }
                
                switch answers[2] {
                case 0:
                    if pet.monthlyCost == .low {
                        score += 3
                    } else if pet.monthlyCost == .medium {
                        score += 1
                    } else {
                        score -= 2
                    }
                case 1:
                    if pet.monthlyCost == .medium {
                        score += 3
                    } else if pet.monthlyCost == .low {
                        score += 1
                    } else {
                        score -= 1
                    }
                case 2:
                    score += 1
                default:
                    break
                }
                
                switch answers[3] {
                case 0:
                    if pet.activityLevel == .low {
                        score += 3
                    } else if pet.activityLevel == .medium {
                        score += 1
                    } else {
                        score -= 2
                    }
                case 1:
                    if pet.activityLevel == .medium {
                        score += 3
                    } else {
                        score += 1
                    }
                case 2:
                    if pet.activityLevel == .high {
                        score += 3
                    } else if pet.activityLevel == .medium {
                        score += 2
                    } else {
                        score -= 2
                    }
                default:
                    break
                }
                
                if answers[4] == 0 {
                    if pet.childrenFriendly == true {
                        score += 3
                    } else {
                        score -= 3
                    }
                }
                
                if answers[5] == 0 {
                    if pet.hypoallergenic == true || pet.allergyFriendly == true {
                        score += 4
                    } else {
                        score -= 4
                    }
                }
                
                switch answers[6] {
                case 0:
                    if pet.socialLevel == .verySocial {
                        score += 3
                    } else if pet.socialLevel == .moderate {
                        score += 1
                    }
                case 1:
                    if pet.childrenFriendly {
                        score += 3
                    } else {
                        score -= 2
                    }
                case 2:
                    if pet.socialLevel == .independent {
                        score += 3
                    }
                    if pet.noiseLevel == .low {
                        score += 1
                    }
                case 3:
                    if pet.activityLevel == .high{
                        score += 3
                    } else {
                        score -= 1
                            }
                default:
                    break
                }
                
                
                switch answers[7] {
                case 0:
                    if pet.size == .small {
                        score += 3
                    } else if pet.size == .medium {
                        score += 1
                    } else {
                        score -= 2
                    }
                case 1:
                    if pet.size == .medium {
                        score += 3
                    } else {
                        score += 1
                    }
                case 2:
                    if pet.size == .large {
                           score += 3
                       } else {
                           score += 2
                       }

                default:
                    break
                }
                
                switch answers[8] {
                case 0:
                    if pet.aloneTime == .high || pet.activityLevel == .low || pet.socialLevel == .independent {
                        score += 3
                    }
                    if pet.socialLevel == .independent || pet.aloneTime == .medium{
                        score += 1
                    }
                    if pet.socialLevel == .verySocial || pet.aloneTime == .low{
                        score -= 3
                    }
                case 1:
                    if pet.socialLevel == .moderate || pet.activityLevel == .high || pet.aloneTime == .medium {
                        score += 3
                    }
                case 2:
                    if pet.activityLevel == .high || pet.aloneTime == .low {
                        score += 3
                    } else {
                        score -= 1
                    }
                default:
                    break
                }
                
                switch answers[9] {
                case 0:
                    if pet.noiseLevel == .low {
                        score += 3
                    } else if pet.noiseLevel == .medium {
                        score += 1
                    } else {
                        score -= 3
                    }
                case 1:
                    if pet.noiseLevel == .medium {
                        score += 2
                    } else {
                        score += 1
                    }
                case 2:
                    score += 3
                default:
                    break
                }
                    
                switch answers[10] {
                case 0:
                    score += 3
                case 1:
                    if pet.sheddingLevel == .low || pet.sheddingLevel == .medium {
                        score += 2
                    } else {
                        score -= 1
                    }
                case 2:
                    if pet.sheddingLevel == .low {
                        score += 4
                    } else if pet.sheddingLevel == .medium {
                        score += 1
                    } else {
                        score -= 3
                    }
                default:
                    break
                }
                    return (pet, score)
                }
            let excludedPets = ["Dog", "Cat", "Parrot"]
            let result = scoredPets
                .sorted{$0.score > $1.score}
                .map{$0.pet}
                .filter{!excludedPets.contains($0.name)}
                .prefix(3)
           
                self.recommendedPets.value = Array(result)
    } catch {
        assertionFailure("Failed to decode pets: \(error)")
    }
}
    
    func openDetails(_ pet: RecommendedPets){
        coordinator?.openDetailPage(pet)
    }
}


