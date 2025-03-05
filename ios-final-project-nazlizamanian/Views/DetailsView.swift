//
//  DetailsView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import SwiftUI

//refactor this code its similar hmmm

struct DetailsView: View {
    let meal: Recipe
  
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
                        Text(meal.ingredients.joined(separator: ", "))
                       
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
                                Text(meal.instructions[index])
                            }
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(16)
                    .padding(.horizontal)
                }
                
                Spacer()
            }
            .padding(.vertical)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


struct DetailsOverlay: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {

                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .lineLimit(nil)

                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= Int(recipe.rating) ? "star.fill" : "star")
                            .foregroundColor(index <= Int(recipe.rating) ? .yellow : .gray)
                    }
                    Text("(\(Int(recipe.reviewCount)) Reviews)")
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)

                HStack {
                    Spacer()
                    VStack {
                        Text("Prep Time")
                            .foregroundColor(Color.gray)
                        Text("\(String(format: "%.0f", recipe.prepTimeMinutes))m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()

                    VStack {
                        Text("Cook Time")
                            .foregroundColor(Color.gray)
                        Text("\(String(format: "%.0f", recipe.prepTimeMinutes))m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                if !recipe.ingredients.isEmpty {
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)

                    Text(recipe.ingredients.joined(separator: ", "))
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .lineLimit(nil)
                }

                if !recipe.instructions.isEmpty {
                    Text("Instructions")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)

                    ForEach(recipe.instructions, id: \.self) { instruction in
                        Text(instruction)
                            .padding(.horizontal)
                            .padding(.bottom, 3)
                            .lineLimit(nil) // Allow full display
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.4))
            .cornerRadius(20)
            .padding(.top, 30)
            .shadow(radius: 10)
        }
        .frame(height: 400)
    }
}
