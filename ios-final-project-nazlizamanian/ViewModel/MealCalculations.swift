//
//  MealCalculations.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/03/25.
//

import Foundation
import Observation

@Observable
class MealCalculations{
    
    var courses: [Recipe] = [] //stores the list of recipes from our api
    
    let assignedMeals: [Date: [String: Recipe]]
        //6 dic O(1)
    
    
    func assignMeal(for date: Date, mealType: String, recipe: Recipe) {
        if assignedMeals[date] == nil { //6
            assignedMeals[date] = [:] //initzal a dic for this date
        }
        assignedMeals[date]?[mealType] = recipe //asing that recipe for that date obj måste va utanflr annars kan vi inte add flera mealtypes, om date redan finns
    }

    func getMeal(for date: Date, mealType: String) -> Recipe? {
        return assignedMeals[date]?[mealType] //Hämta recept annars nil
    }
    func calculateCalories(for date: Date) -> Int {
        if let mealsPerDate = assignedMeals[date]{ //7 if meals exisist for the date add
            return mealsPerDate.values.reduce(0){ $0 + $1.caloriesPerServing} //current running totalt + current recipe obj
        }
        else { return 0 }
    }
    
    func calculateCookTime(for date: Date) -> Double{
        if let mealsPerDate = assignedMeals[date]{
            
            let totalCookTimePerMeal = mealsPerDate.values.reduce(0){totalTime, recipe in //hämta alla recept för dagen
                
                let prepTime = recipe.prepTimeMinutes
                let cookTime = recipe.cookTimeMinutes
                
                let totalTimePerRecipe = (prepTime / Double(recipe.servings))+cookTime //ex pizza 20/4= 5 + 15 = 20
                
                
                return totalTime + totalTimePerRecipe
            }
            return totalCookTimePerMeal
            
        }
        else { return 0.0 }
    }
}
