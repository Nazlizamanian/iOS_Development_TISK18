//
//  DailyMeals.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 03/03/25.
//

import Foundation
import SwiftData

@Model
final class Meal {
    @Attribute(.unique) var id: Int
    var type: MealType
    var recipe: FavoriteRecipe

    init(id: Int, type: MealType, recipe: FavoriteRecipe) {
        self.id = id
        self.type = type
        self.recipe = recipe
    }
}

@Model
final class Day {
    @Attribute(.unique) var id: Int
    var date: Date
    var meals: [Meal]

    init(id: Int,date: Date, meals: [Meal] = []) {
        self.id = id
        self.date = date
        self.meals = meals
    }
}
