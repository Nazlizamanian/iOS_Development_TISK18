//
//  RecipeModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 29/06/24.
//

import Foundation
import SwiftData

/**Model**/
struct Recipe: Codable, Hashable, Identifiable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let image: String
    let difficulty: String
    let rating: Double
    let cuisine: String
    let prepTimeMinutes: Double
    let cookTimeMinutes: Double
    let servings: Int
    let caloriesPerServing: Int
    let reviewCount: Int

    // Initializer from FavoriteRecipe
    init(from favorite: FavoriteRecipe) {
        self.id = favorite.id
        self.name = favorite.name
        self.ingredients = favorite.ingredients
        self.instructions = favorite.instructions
        self.image = favorite.image
        self.difficulty = favorite.difficulty
        self.rating = favorite.rating
        self.cuisine = favorite.cuisine
        self.prepTimeMinutes = favorite.prepTimeMinutes
        self.cookTimeMinutes = favorite.cookTimeMinutes
        self.servings = favorite.servings
        self.caloriesPerServing = favorite.caloriesPerServing
        self.reviewCount = favorite.reviewCount
    }
}



struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

