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



/*ViewModel handles the presentation logic, interacts with our model to fetch and update data*/
class MealsModel: ObservableObject {
    @Published var courses: [Recipe] = []
    @Published var favoriteRecipes: [Recipe] = [] //we gonna add the favs to this array
    
    var modelContext: ModelContext?
    func fetch() {
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
    
    func addToFavorites(recipe: Recipe) {
        if !favoriteRecipes.contains(where: { $0.id == recipe.id }) {
            favoriteRecipes.append(recipe)
        }
    }
    func removeFromFavorites(recipe: Recipe){ //Lägg till swipa b ort func.
        favoriteRecipes.removeAll{ $0.id == recipe.id}
    }
    
    func filterRecipes(byDifficulties difficulties: [String]) -> [Recipe] {
        return courses.filter { difficulties.contains($0.difficulty.lowercased()) }    }

}
