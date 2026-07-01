//
//  Models.swift
//  Pet App
//
//  Created by Margarita Matsonko on 20/06/2026.
//

import UIKit

struct Questions: Codable{
    let text: String
    let options:[String]
}

struct Pet: Codable{
    let name: String
    let description: String
    let imageName: String
    let monthlyCost: MonthlyCost
    let activityLevel: ActivityLevel
    let housing: Housing
    let social: Social
    let childrenFriendly: Bool
    let noiseLevel: NoiseLevel
    let aloneTime: AloneTime
    let allergyFriendly: Bool
    let height: String?
    let weight: String?
    let lifespan: String?
    let info: String?
    
    var characteristics: [Characteristics] {
        var items: [Characteristics] = []
        
        items.append(Characteristics(title: "Activity Level", value: activityLevel.value, icon: "figure.run", color: activityLevel.color))
        items.append(Characteristics(title: "Noise Level", value: noiseLevel.value, icon: "speaker.wave.2.fill", color: noiseLevel.color))
        items.append(Characteristics(title: "Housing", value: housing.value, icon: "house.fill", color: housing.color))
        items.append(Characteristics(title: "Monthly Cost", value: monthlyCost.value, icon: "creditcard.fill", color: monthlyCost.color))
        items.append(Characteristics(title: "Alone time", value: aloneTime.value, icon: "clock.fill", color: aloneTime.color))
        items.append(Characteristics(title: "Social Level", value: social.value, icon: "person.2.fill", color: social.color))
        items.append(Characteristics(title: "Good with children", value: childrenFriendly.value, icon: "figure.and.child.holdinghands", color: childrenFriendly.color))
        items.append(Characteristics(title: "Good with allergy", value: allergyFriendly.value, icon: "leaf.fill", color: allergyFriendly.color ))
        
        return items
    }
}

struct Breed: Codable {
    let name: String
    let description: String
    let imageName: String
    let size: Size
    let activityLevel: ActivityLevel
    let groomingLevel: GroomingLevel
    let sheddingLevel: SheddingLevel
    let childrenFriendly: Bool
    let apartmentFriendly: Bool
    let hypoallergenic: Bool
    let height: String
    let weight: String
    let lifespan: String
    let info: String
    
    var characteristics: [Characteristics] {
        var items: [Characteristics] = []
        
        items.append(Characteristics(title: "Size", value: size.value, icon: "ruler", color: size.color))
        items.append(Characteristics(title: "Activity Level", value: activityLevel.value, icon: "figure.run", color: activityLevel.color))
        items.append(Characteristics(title: "Grooming Level", value: groomingLevel.value, icon: "scissors", color: groomingLevel.color))
        items.append(Characteristics(title: "Shedding Level", value: sheddingLevel.value, icon: "hare.fill", color: sheddingLevel.color))
        items.append(Characteristics(title: "Good with children", value: childrenFriendly.value, icon: "figure.and.child.holdinghands", color: childrenFriendly.color))
        items.append(Characteristics(title: "Apartment friendly", value: apartmentFriendly.value, icon: "house.fill", color: apartmentFriendly.color))
        items.append(Characteristics(title: "Good with allergy", value: hypoallergenic.value, icon: "leaf.fill", color: hypoallergenic.color))
        
        return items
    }
}


struct BirdBreed: Codable {
    let name: String
    let description: String
    let imageName: String
    let size: Size
    let activityLevel: ActivityLevel
    let noiseLevel: NoiseLevel
    let socialLevel: Social
    let talkingAbility: TalkingAbility
    let childrenFriendly: Bool
    let apartmentFriendly: Bool
    let hypoallergenic: Bool
    let height: String
    let weight: String
    let lifespan: String
    let info: String
    
    var characteristics: [Characteristics] {
        var items: [Characteristics] = []
        
        items.append(Characteristics(title: "Size", value: size.value, icon: "ruler", color: size.color))
        items.append(Characteristics(title: "Activity Level", value: activityLevel.value, icon: "figure.run", color: activityLevel.color))
        items.append(Characteristics(title: "Talking Ability", value: talkingAbility.value, icon: "bubble.left", color: talkingAbility.color))
        items.append(Characteristics(title: "Noise Level" , value: noiseLevel.value, icon: "speaker.wave.2.fill", color: noiseLevel.color))
        items.append(Characteristics(title: "Social Level" , value: socialLevel.value, icon: "person.2.fill", color: socialLevel.color))
        items.append(Characteristics(title: "Good with children", value: childrenFriendly.value, icon: "figure.and.child.holdinghands", color: childrenFriendly.color))
        items.append(Characteristics(title: "Apartment friendly", value: apartmentFriendly.value, icon: "house.fill", color: apartmentFriendly.color))
        items.append(Characteristics(title: "Good with allergy", value: hypoallergenic.value, icon: "leaf.fill", color: hypoallergenic.color))
        
        return items
    }
}

enum TalkingAbility: String, Codable {
    case low
    case medium
    case high
    
    var value: String {
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: UIColor{
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}

enum SheddingLevel: String, Codable {
    case low
    case medium
    case high
    
    var value: String{
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: UIColor{
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}

enum Size: String, Codable{
    case small
    case medium
    case large
    
    var value: String{
        switch self {
        case .small:
            return "Small"
        case .medium:
            return "Medium"
        case .large:
            return "Large"
        }
    }
    
    var color: UIColor{
        switch self {
        case .small:
            return .green
        case .medium:
            return .orange
        case .large:
            return .red
        }
    }
}

enum GroomingLevel: String, Codable{
    case low
    case medium
    case high
    
    var value: String{
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: UIColor{
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}
               
enum MonthlyCost: String, Codable{
    case low
    case medium
    case high
    
    var value: String{
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: UIColor{
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}

enum ActivityLevel: String, Codable{
    case low
    case medium
    case high
    
    var value: String{
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: UIColor{
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}

enum Housing: String, Codable{
    case apartment
    case house
    
    var value: String{
        switch self {
        case .apartment:
            return "Apartment"
        case .house:
            return "House"
        }
    }
    
    var color: UIColor{
        switch self {
        case .apartment:
            return .green
        case .house:
            return .orange
        }
    }
}

enum Social: String, Codable{
    case independent
    case moderate
    case verySocial
    
    var value: String{
        switch self {
        case .independent:
            return "Independent"
        case .moderate:
            return "Moderate"
        case .verySocial:
            return "Very social"
        }
    }
    
    var color: UIColor{
        switch self {
        case .independent:
            return .green
        case .moderate:
            return .orange
        case .verySocial:
            return .red
        }
    }
}

enum NoiseLevel: String, Codable{
    case low
    case medium
    case high
    
    var value: String{
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: UIColor{
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}

enum AloneTime: String, Codable{
    case low
    case medium
    case high
    
    var value: String{
        switch self {
        case .low:
            return "Low"
        case .medium:
            return "Medium"
        case .high:
            return "High"
        }
    }
    
    var color: UIColor{
        switch self {
        case .low:
            return .green
        case .medium:
            return .orange
        case .high:
            return .red
        }
    }
}

extension Bool {
    var value: String {
        self ? "Yes" : "No"
    }
    
    var color: UIColor{
        self ? .green : .red
    }
}

