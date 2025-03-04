//
//  RecipePicker.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 03/03/25.
//

import Foundation
import SwiftUI

struct RecipePickerView: View {
    var recipes: [Recipe]
    var mealType: String
    var model: MealsModel
    var onSelect: (Recipe) -> Void
    
    var body: some View {
        NavigationStack {
            List(recipes) { recipe in
                Button {
                    onSelect(recipe)
                } label: {
                    HStack {
                        URLImage(urlString: recipe.image)
                            .frame(width: 50, height: 50)
                            .cornerRadius(10)
                        
                        Text(recipe.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        Spacer()
                        if !model.containsMeat(ingredients: recipe.ingredients) {
                            Image(systemName:"leaf.fill")
                                .font(.system(size: 50))
                                .foregroundColor(.green)
                        }
                    }
                }
            }
            .navigationTitle("Choose \(mealType)")
        }
    }
}


