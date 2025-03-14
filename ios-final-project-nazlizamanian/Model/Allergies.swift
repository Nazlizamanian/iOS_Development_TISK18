//
//  Allergies.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 13/03/25.
//


enum Allergies: String, CaseIterable {
    case gluten = "gluten"
    case dairy = "dairy"
    case fish = "fish"
    case soy = "soy"
    case peanut = "peanut"
    
    var emoji: String {
        switch self {
        case .gluten:
            return "🌾"
        case .dairy:
            return "🥛"
        case .fish:
            return "🐟"
        case .soy:
            return "🌱"
        case .peanut:
            return "🥜"
        }
        
    }
    
    var keywords: [String] {
        switch self {
        case .gluten:
            return ["flour", "wheat", "dough", "pasta", "bread"]
        case .dairy:
            return ["milk", "cheese", "butter", "cream"]
        case .fish:
            return ["fish"]
        case .soy:
            return ["soy", "tofu", "soy sauce"]
        case .peanut:
            return ["peanut"]
        }
    }
}

