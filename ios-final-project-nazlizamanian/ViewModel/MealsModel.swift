//
//  MealsModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import Foundation
import SwiftUI
import SwiftData
import Combine
import Observation

/*Sources used:
 5. Fetching data from api: https://anjalijoshi2426.medium.com/fetch-and-display-api-data-on-list-using-swiftui-13fff61e8826
 
 6. working with dictiornary: https://medium.com/@kishorepremkumar/dictionaries-in-swift-e03c14660b7

 7. Sum array using reduce: https://www.hackingwithswift.com/example-code/language/how-to-sum-an-array-of-numbers-using-reduce*/

/*ViewModel handles the presentation logic, interacts with our model to fetch and update data*/

//ToDO:
// 3. unit testing
//4. Swiftdata save liked list and assignedMeals

@Observable
class MealsModel: Identifiable {
    var courses: [Recipe] = [] //stores the list of recipes from our api
    var favoriteRecipes: [Recipe] = [] //we gonna add the favs to this array
    var assignedMeals: [Date: [String: Recipe]] = [:] //6 dic O(1) 
    
    
    func fetch() { //5
        guard let url = URL(string: "https://dummyjson.com/recipes?limit=0") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let recipesResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
                
                DispatchQueue.main.async {
                    self?.courses = recipesResponse.recipes
                }
                
                // Print or use the first recipe in the list
                if let firstRecipe = self?.courses.first {
                    print("Recipe Name: \(firstRecipe.name)")
                    print("Instructions:")
                    for instruction in firstRecipe.instructions {
                        print("- \(instruction)")
                    }
                    print("Image URL: \(firstRecipe.image)")
                } else {
                    print("No recipes found")
                }
                
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
        
        task.resume() // Resume the task to initiate the request
    }
    
    func addToFavorites(recipe: Recipe, in context: ModelContext) { //CHatis projectIos ask about the sorcing how t source the saved projct
            let favoriteRecipe = FavoriteRecipe(
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
            context.insert(favoriteRecipe)
            try? context.save()
        }
    
  
    
    //filteres courses []
    func filterRecipes(byDifficulties difficulties: [String]) -> [Recipe] {
        return courses.filter { difficulties.contains($0.difficulty.lowercased()) }    }

    
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
    
    func containsMeat(ingredients: [String]) -> Bool {
        let meats = ["beef", "chicken", "fish", "lamb"]
        
        for ingredient in ingredients {
            let words = ingredient.lowercased().components(separatedBy: " ")  // Split
            
            for word in words {
                if meats.contains(word) {  
                    return true
                }
            }
        }
        
        return false
    }

    
    
    
}

