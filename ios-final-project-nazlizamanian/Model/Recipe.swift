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
        if self == .breakfast { return "cup.and.saucer"}
        else if self == .lunch || self == .dinner { return "fork.knife.circle" }
        else { return "takeoutbag.and.cup.and.straw"}
       
    }
}

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


@Model
final class FavoriteRecipe {
    @Attribute(.unique) var id: Int
    var name: String
    var image: String
    var ingredients: [String]
    var instructions: [String]
    var difficulty: String
    var rating: Double
    var cuisine: String
    var prepTimeMinutes: Double
    var cookTimeMinutes: Double
    var servings: Int
    var caloriesPerServing: Int
    var reviewCount: Int

    init(id: Int, name: String, image: String, ingredients: [String], instructions: [String], difficulty: String, rating: Double, cuisine: String, prepTimeMinutes: Double, cookTimeMinutes: Double, servings: Int, caloriesPerServing: Int, reviewCount: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.instructions = instructions
        self.difficulty = difficulty
        self.rating = rating
        self.cuisine = cuisine
        self.prepTimeMinutes = prepTimeMinutes
        self.cookTimeMinutes = cookTimeMinutes
        self.servings = servings
        self.caloriesPerServing = caloriesPerServing
        self.reviewCount = reviewCount
    }
    
    // Convenience initializer from Recipe
    convenience init(from recipe: Recipe) {
        self.init(
            id: recipe.id,
            name: recipe.name,
            image: recipe.image,
            ingredients: recipe.ingredients,
            instructions: recipe.instructions,
            difficulty: recipe.difficulty,
            rating: recipe.rating,
            cuisine: recipe.cuisine,
            prepTimeMinutes: recipe.prepTimeMinutes,
            cookTimeMinutes: recipe.cookTimeMinutes,
            servings: recipe.servings,
            caloriesPerServing: recipe.caloriesPerServing,
            reviewCount: recipe.reviewCount
        )
    }
}
