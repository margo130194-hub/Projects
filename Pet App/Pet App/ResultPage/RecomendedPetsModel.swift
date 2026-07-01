//
//  RecomendedPetsModel.swift
//  Pet App
//
//  Created by Margarita Matsonko on 26/06/2026.
//

import UIKit

struct RecommendedPets: Codable{
    let name: String
    let description: String
    let imageName: String
    let activityLevel: ActivityLevel
    let childrenFriendly: Bool
    let apartmentFriendly: Bool?
    let hypoallergenic: Bool?
    let sheddingLevel: SheddingLevel?
    let groomingLevel: GroomingLevel?
    let noiseLevel: NoiseLevel?
    let allergyFriendly: Bool?
    let socialLevel: Social?
    let monthlyCost: MonthlyCost?
    let housing: Housing?
    let aloneTime: AloneTime?
    let size: Size?
    let talkingAbility: TalkingAbility?
    let lifespan: String?
    let weight: String?
    let height: String?
    let info: String?
    
    var characteristics: [Characteristics] {
        var items: [Characteristics] = []
        
        if let size {
            items.append(Characteristics(title: "Size", value: size.value, icon: "ruler", color: size.color))
        }
        items.append(Characteristics(title: "Activity Level", value: activityLevel.value, icon: "figure.run", color: activityLevel.color))
        if let talkingAbility{
            items.append(Characteristics(title: "Talking Ability", value: talkingAbility.value, icon: "bubble.left", color: talkingAbility.color))
        }
        if let noiseLevel{
            items.append(Characteristics(title: "Noise Level" , value: noiseLevel.value, icon: "speaker.wave.2.fill", color: noiseLevel.color))
        }
        if let socialLevel{
            items.append(Characteristics(title: "Social Level" , value: socialLevel.value, icon: "person.2.fill", color: socialLevel.color))
        }
        items.append(Characteristics(title: "Good with children", value: childrenFriendly.value, icon: "figure.and.child.holdinghands", color: childrenFriendly.color))
        if let apartmentFriendly{
            items.append(Characteristics(title: "Apartment friendly", value: apartmentFriendly.value, icon: "house.fill", color: apartmentFriendly.color))
        }
        if let hypoallergenic{
            items.append(Characteristics(title: "Good with allergy", value: hypoallergenic.value, icon: "leaf.fill", color: hypoallergenic.color))
        }
        return items
    }
    
    var information: [Info] {
        var items: [Info] = []
        
        if let lifespan {
            items.append(Info(titleInfo: "Lifespan", valueInfo: lifespan, iconInfo: "calendar"))
        }
        
        if let weight{
            items.append(Info(titleInfo: "Weight", valueInfo: weight, iconInfo: "scalemass"))
        }
        
        if let height{
            items.append(Info(titleInfo: "Height", valueInfo: height, iconInfo: "ruler"))
        }
        return items
    }
}

