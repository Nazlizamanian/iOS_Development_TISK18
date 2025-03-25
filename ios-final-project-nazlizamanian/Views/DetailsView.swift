//
//  DetailsView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import SwiftUI

struct DetailsView: View {
    let recipe: Recipe
    let model: MealsModel
  
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                URLImage(urlString: recipe.image)
                    .frame(height: 350)
                    .frame(maxWidth: .infinity)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(recipe.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 4) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= Int(recipe.rating) ? "star.fill" : "star")
                                .foregroundColor(index <= Int(recipe.rating) ? .yellow : .gray)
                        }
                        Text("(\(Int(recipe.reviewCount)) Reviews)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        Spacer()
                        Text(String(format: "%.1f", Double(recipe.rating)))
                            .fontWeight(.bold)

                    }
                }
                .padding(.horizontal)
                
                HStack(spacing: 20) {
                    VStack(spacing: 3) {
                        Image(systemName: "clock")
                            .foregroundColor(.mint)
                            .font(.system(size: 30))
                        Text("Prep Time")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("\(Int(recipe.prepTimeMinutes))m")
                            .font(.headline)
                    }
                    
                    VStack(spacing: 3) {
                        Image(systemName: "timer")
                            .foregroundColor(.mint)
                            .font(.system(size: 30))
                        Text("Cook Time")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(Int(recipe.cookTimeMinutes))m")
                            .font(.headline)
                    }
                    
                    VStack(spacing: 3) {
                        Image(systemName: "flame")
                            .foregroundColor(.mint)
                            .font(.system(size: 30))
                        Text("Calories")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(recipe.caloriesPerServing) kcal")
                            .font(.headline)
                    }
                    
                    VStack(spacing: 1){
                        if let cusine = Cuisine(rawValue: recipe.cuisine){
                            Text(cusine.flag)
                                .font(.system(size: 35))
                            Text("Cusine")
                                .font(.caption)
                                .foregroundColor(.gray)
                                .padding(.top, -4)
                            Text(cusine.rawValue)
                                .font(.headline)
                        }
                    }
                }//HStack
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .padding(.horizontal)
                
                //cause each recipe has an [] of ingredient object and we want to check each ingriedneitn obj .map transforms into [] of name strings
                if !model.containsAllergens(ingredients: recipe.ingredients.map { $0.name }).isEmpty {
                    HStack(spacing: 20) {
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.mint)
                            .font(.system(size: 45))
                        
                        VStack(alignment: .leading, spacing: 3) {
                            Text("This recipe contains the following allergens")
                                .font(.headline)
                            HStack {
                                ForEach(model.containsAllergens(ingredients: recipe.ingredients.map { $0.name }), id: \.self) { allergen in
                                    HStack(spacing: 10) {
                                        VStack{
                                            Text(allergen.emoji)
                                                .font(.system(size: 30))
                                            Text(allergen.rawValue.capitalized)
                                                .font(.caption)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                    .padding(.trailing, 5)
                                }
                            }
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                
                HStack{
                    if !recipe.ingredients.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Ingredients")
                                .font(.title2)
                                .fontWeight(.bold)
                            Text(recipe.ingredients.map { $0.name }.joined(separator: ", "))
                           
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .padding(.horizontal)
                
                HStack{
                    if !recipe.instructions.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Instructions")
                                .font(.title2)
                                .fontWeight(.bold)
                            
                            ForEach(recipe.instructions.indices, id: \.self) { index in
                                HStack(alignment: .top, spacing: 8) {
                                    Text("\(index + 1).")
                                        .fontWeight(.bold)
                                    Text(recipe.instructions[index].name)
                                }
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(16)
                .padding(.horizontal)
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

