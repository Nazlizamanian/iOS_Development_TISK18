//
//  RecipeModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 29/06/24.
//

import Foundation
import SwiftData

enum MealType: String, CaseIterable {
    case breakfast = "Breakfast"
    case lunch = "Lunch"
    case dinner = "Dinner"
    case snacks = "Snacks"

    var title: String { rawValue }
    var iconName: String {
        switch self {
        case .breakfast: return "cup.and.saucer"
        case .lunch: return "fork.knife.circle"
        case .dinner: return "fork.knife.circle"
        case .snacks: return "takeoutbag.and.cup.and.straw"
        }
    }
}

/**Model**/
struct Recipe: Codable, Hashable, Identifiable{
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let image: String
    let difficulty: String
    let rating: Double
    let cuisine: String
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let caloriesPerServing: Int
    let reviewCount: Int
}


struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

@Model
final class RecipeFavList{
    @Attribute(.unique) let id: Int
    let name: String
    let image: String
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
