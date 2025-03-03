//
//  FavoriteRecipe.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/03/25.
//

import Foundation
import SwiftData

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
}
