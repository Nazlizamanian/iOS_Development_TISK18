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
 6. MainActor instead of DispatchQueue.: https://hasanalidev.medium.com/mainactor-swiftui-4d7b2545927c
 7. Sum array using reduce: https://www.hackingwithswift.com/example-code/language/how-to-sum-an-array-of-numbers-using-reduce*/

@Observable
class MealsModel: Identifiable {
    var courses: [Recipe] = [] //stores the list of recipes from our api
    
    func fetch() async {
        guard let url = URL(string: "https://dummyjson.com/recipes?limit=0") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // Decode the JSON response into your RecipesResponse type
            let recipesResponse = try JSONDecoder().decode(RecipesResponse.self, from: data)
            
            //6
            await MainActor.run {
                self.courses = recipesResponse.recipes
            }
        } catch {
            print("Error fetching or decoding data: \(error)")
        }
    }

    
    func alreadyInFavorites(recipe: Recipe, favoriteRecipes: FavoriteRecipes, context: ModelContext) {
        
        if !favoriteRecipes.favoriteRecipes.contains(where: { $0.id == recipe.id }) {
            
            favoriteRecipes.favoriteRecipes.append(recipe)
            
            do {
                try context.save()
                print("Recipe added to favorites and saved successfully.")
            } catch {
                print("Failed to save recipe to favorites: \(error)")
            }
        } else {
            print("Recipe is already in favorites.")
        }
    }
    
    func removeFromFavorites(recipe: Recipe, favoriteRecipes: FavoriteRecipes, context: ModelContext){
        if let index = favoriteRecipes.favoriteRecipes.firstIndex(where: {$0.id == recipe.id}){
            favoriteRecipes.favoriteRecipes.remove(at: index)
            
            do{
                try context.save()
            }catch{
                print("Failed to remove recipe to favorites: \(error)")
            }
        } else {
            print("Recipe is not in fav.")
        }
    }
    
    func assignRecipe( _ recipe: Recipe, to mealType: MealType, on day: Day, context: ModelContext) { //CHATIS
        let meal = Meal(type: mealType, recipe: recipe, day: day)
        day.meals.append(meal)
        
        do {
            try context.save()
            print("\(recipe.name) added to \(mealType.title) on \(day.date)")
        } catch {
            print("Failed to save meal: \(error)")
        }
    }
    
    func loadOrCreateDay(for date: Date, context: ModelContext) -> Day { //CHatis
        let calendar = Calendar.current
        let startOfDay = calendar.startOfDay(for: date)

        if let existingDay = try? context.fetch(
            FetchDescriptor<Day>(predicate: #Predicate { $0.date == startOfDay })
        ).first {
            return existingDay
        } else {
            let newDay = Day(date: startOfDay)
            context.insert(newDay)
            try? context.save()
            return newDay
        }
    }

    //filteres courses []
    func filterRecipes(byDifficulties difficulties: [String]) -> [Recipe] {
        return courses.filter { difficulties.contains($0.difficulty.lowercased()) }    }

    func calculateCalories(for day: Day?) ->Int { //7
        guard let day = day else { return 0 }
        return day.meals.reduce(0) {$0 + $1.recipe.caloriesPerServing}
    }
    
    func calculateCookTime(for day: Day?) -> Double {
        guard let day = day else { return 0 }
        
        return day.meals.reduce(0) { total, meal in
            let recipe = meal.recipe
            let cookTime = (recipe.prepTimeMinutes / Double(recipe.servings)) + recipe.cookTimeMinutes
            
            return total + cookTime
        }
    }
    
    func containsMeat(ingredients: [String]) -> Bool {
        //"Grilled chichekn slices" vs "Chicken, cut into pieces"
        for ingredient in ingredients {
            let words = ingredient.lowercased().components(separatedBy: " ")  // Split
            
            for word in words {
                let cleanWord = word.trimmingCharacters(in: .punctuationCharacters)
                if Meat.allCases.contains(where: {$0.rawValue == cleanWord}) {
                    return true
                }
            }
        }
        
        return false
    }
    
}

