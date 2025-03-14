//
//  DetailsView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import SwiftUI

struct DetailsView: View {
    let meal: Recipe
    let model: MealsModel
  
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                
                URLImage(urlString: meal.image)
                    .frame(height: 350)
                    .frame(maxWidth: .infinity)
                    .clipped()
                
                VStack(alignment: .leading, spacing: 12) {
                    Text(meal.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    HStack(spacing: 4) {
                        ForEach(1...5, id: \.self) { index in
                            Image(systemName: index <= Int(meal.rating) ? "star.fill" : "star")
                                .foregroundColor(index <= Int(meal.rating) ? .yellow : .gray)
                        }
                        Text("(\(Int(meal.reviewCount)) Reviews)")
                            .foregroundColor(.gray)
                            .font(.subheadline)
                        
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

                        Text("\(Int(meal.prepTimeMinutes))m")
                            .font(.headline)
                    }
                    
                    VStack(spacing: 3) {
                        Image(systemName: "timer")
                            .foregroundColor(.mint)
                            .font(.system(size: 30))
                        Text("Cook Time")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(Int(meal.cookTimeMinutes))m")
                            .font(.headline)
                    }
                    
                    VStack(spacing: 3) {
                        Image(systemName: "flame")
                            .foregroundColor(.mint)
                            .font(.system(size: 30))
                        Text("Calories")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Text("\(meal.caloriesPerServing) kcal")
                            .font(.headline)
                    }
                    
                    VStack(spacing: 1){
                        if let cusine = Cuisine(rawValue: meal.cuisine){
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
                
                if !meal.ingredients.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Ingredients")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text(meal.ingredients.map { $0.name }.joined(separator: ", "))
                       
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                
                if !meal.instructions.isEmpty {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Instructions")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        ForEach(meal.instructions.indices, id: \.self) { index in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(index + 1).")
                                    .fontWeight(.bold)
                                Text(meal.instructions[index].name)
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    ForEach(model.containsAllergens(ingredients: meal.ingredients.map{$0.name}), id: \.self){ allergen in
                        Text(allergen.rawValue.capitalized)
                        Text(allergen.emoji)
                        
                    }
                }
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

