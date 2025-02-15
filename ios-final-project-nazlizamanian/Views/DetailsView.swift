//
//  DetailsView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import SwiftUI

struct DetailsView: View {
    let meal: Recipe
    @State private var addToMealPlan = false
    @State private var showCartAlert = false // New state for cart button
    @EnvironmentObject var shoppingListVM: ShoppingListViewModel
        
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                Text(meal.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= Int(meal.rating) ? "star.fill" : "star")
                            .foregroundColor(index <= Int(meal.rating) ? .yellow : .gray)
                    }
                    Text("(\(Int(meal.reviewCount)) Reviews)")
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)
                
                HStack{
                    Spacer()
                    VStack {
                        Text("Prep Time")
                            .foregroundColor(Color.gray)
                        Text("\(meal.prepTimeMinutes)m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    
                    VStack {
                        Text("Cook Time")
                            .foregroundColor(Color.gray)
                        Text("\(meal.cookTimeMinutes)m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()
                    
                }
                if !meal.ingredients.isEmpty {
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                    
                    Text(meal.ingredients.joined(separator: ", "))
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                }
                
                if !meal.instructions.isEmpty {
                    Text("Instructions")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                    
                    ForEach(meal.instructions, id: \.self) { instruction in
                        Text(instruction)
                            .padding(.horizontal)
                            .padding(.bottom, 3)
                    }
                }
                
                Spacer()
                
            }
        }
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
                        Text("\(recipe.prepTimeMinutes)m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()

                    VStack {
                        Text("Cook Time")
                            .foregroundColor(Color.gray)
                        Text("\(recipe.cookTimeMinutes)m")
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
