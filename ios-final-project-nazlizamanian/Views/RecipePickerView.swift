//
//  RecipePicker.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 03/03/25.
//

import Foundation
import SwiftUI

struct RecipePickerView: View {
    var mealType: MealType
    var day: Day
    var favoriteRecipes: [Recipe]
    var model: MealsModel
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationView {
            List(favoriteRecipes, id: \.id) { recipe in
                Button {
                    model.assignRecipe(recipe, to: mealType, on: day, context: modelContext)
                    dismiss()
                } label: {
                    HStack {
                        URLImage(urlString: recipe.image)
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        
                        if !model.containsMeat(ingredients: recipe.ingredients.map { $0.name }){
                            Image(systemName: "leaf.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .navigationTitle("Choose a meal")
        }
    }
}

