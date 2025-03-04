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
    @Attribute(.unique) var id: UUID = UUID()
    var type: MealType
    var recipe: Recipe
    
    var day: Day?

    init(type: MealType, recipe: Recipe, day: Day){
        self.type = type
        self.recipe = recipe
        self.day = day
    }
}

@Model
final class Day {
    @Attribute(.unique) var id: UUID = UUID()
    var date: Date
    var meals: [Meal]

    init(date: Date, meals: [Meal] = []) {
        self.date = date
        self.meals = meals
    }
}
