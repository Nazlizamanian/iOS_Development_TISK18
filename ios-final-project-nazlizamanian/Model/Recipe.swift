//
//  RecipeModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 29/06/24.
//

import Foundation
import SwiftData

/*AI/CHATGPT 1-3*/
@Model
final class Recipe: Codable, Identifiable {
    var id: Int
    var name: String
    var ingredients: [Ingredient] //[] of Ingredeint objc
    var instructions: [Instruction]
    var image: String
    var difficulty: String
    var rating: Double
    var cuisine: String
    var prepTimeMinutes: Double
    var cookTimeMinutes: Double
    var servings: Int
    var caloriesPerServing: Int
    var reviewCount: Int

    init(
        id: Int,
        name: String,
        ingredients: [Ingredient],
        instructions: [Instruction],
        image: String,
        difficulty: String,
        rating: Double,
        cuisine: String,
        prepTimeMinutes: Double,
        cookTimeMinutes: Double,
        servings: Int,
        caloriesPerServing: Int,
        reviewCount: Int
    ) {
        self.id = id
        self.name = name
        self.ingredients = ingredients
        self.instructions = instructions
        self.image = image
        self.difficulty = difficulty
        self.rating = rating
        self.cuisine = cuisine
        self.prepTimeMinutes = prepTimeMinutes
        self.cookTimeMinutes = cookTimeMinutes
        self.servings = servings
        self.caloriesPerServing = caloriesPerServing
        self.reviewCount = reviewCount
    }

    enum CodingKeys: String, CodingKey {
        case id, name, ingredients, instructions, image, difficulty, rating, cuisine, prepTimeMinutes, cookTimeMinutes, servings, caloriesPerServing, reviewCount
    }

    // Manual decoding initializer
    convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let id = try container.decode(Int.self, forKey: .id)
        let name = try container.decode(String.self, forKey: .name)
        let ingredientsString = try container.decode([String].self, forKey: .ingredients)
        let instructionsString = try container.decode([String].self, forKey: .instructions)
        let image = try container.decode(String.self, forKey: .image)
        let difficulty = try container.decode(String.self, forKey: .difficulty)
        let rating = try container.decode(Double.self, forKey: .rating)
        let cuisine = try container.decode(String.self, forKey: .cuisine)
        let prepTimeMinutes = try container.decode(Double.self, forKey: .prepTimeMinutes)
        let cookTimeMinutes = try container.decode(Double.self, forKey: .cookTimeMinutes)
        let servings = try container.decode(Int.self, forKey: .servings)
        let caloriesPerServing = try container.decode(Int.self, forKey: .caloriesPerServing)
        let reviewCount = try container.decode(Int.self, forKey: .reviewCount)
        
        let ingredients = ingredientsString.map { Ingredient(name: $0) }
        let instructions = instructionsString.map { Instruction(name: $0) }
        
        self.init(id: id, name: name, ingredients: ingredients, instructions: instructions, image: image, difficulty: difficulty, rating: rating, cuisine: cuisine, prepTimeMinutes: prepTimeMinutes, cookTimeMinutes: cookTimeMinutes, servings: servings, caloriesPerServing: caloriesPerServing, reviewCount: reviewCount)
    }

    // Manual encoding method
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(ingredients, forKey: .ingredients)
        try container.encode(instructions, forKey: .instructions)
        try container.encode(image, forKey: .image)
        try container.encode(difficulty, forKey: .difficulty)
        try container.encode(rating, forKey: .rating)
        try container.encode(cuisine, forKey: .cuisine)
        try container.encode(prepTimeMinutes, forKey: .prepTimeMinutes)
        try container.encode(cookTimeMinutes, forKey: .cookTimeMinutes)
        try container.encode(servings, forKey: .servings)
        try container.encode(caloriesPerServing, forKey: .caloriesPerServing)
        try container.encode(reviewCount, forKey: .reviewCount)
    }

}

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

