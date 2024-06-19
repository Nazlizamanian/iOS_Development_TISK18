//
//  MealsModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import Foundation
import SwiftUI

struct Recipe: Codable, Hashable {
    let id: Int
    let name: String
    let instructions: [String]
    let image: String
}

struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

class MealsModel: ObservableObject {
    @Published var courses: [Recipe] = []
    
    func fetch() {
        guard let url = URL(string: "https://dummyjson.com/recipes?limit=49") else { return }
        
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
}
