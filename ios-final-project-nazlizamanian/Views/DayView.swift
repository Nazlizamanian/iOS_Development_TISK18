//
//  DayView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 11/02/25.

import SwiftUI
import SwiftData

/*
 Soruces used in this file:
 8. iterating over list: https://stackoverflow.com/questions/61187277/swiftui-build-a-list-using-enums
 9. Sheet: https://rryam.com/swiftui-sheet-modifiers?utm_m
 10. Sheet: https://www.hackingwithswift.com/quick-start/swiftui/how-to-present-a-new-view-using-sheets
 */

struct DayView: View {
    var selectedDate: Date

    @Environment(MealsModel.self) var model
    @Environment(\.modelContext) var modelContext
    
    @State private var showRecipePicker = false
    @State private var selectedMealType: String?
    
    @Query private var storedFavorites: [FavoriteRecipes]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 30) {
                // Display selected date
                Text(selectedDate, format: .dateTime.weekday(.wide).day().month(.abbreviated))
                    .font(.largeTitle)
                    .bold()
                    .padding([.horizontal, .top])

                // Dynamic meal sections based on MealType enum
                ForEach(MealType.allCases, id: \.self) { mealType in
                    mealSection(mealType: mealType)
                }

                Spacer()

                // Total calories display
                Text("Total calories for the day: \(model.calculateCalories(for: selectedDate))")
                    .font(.title)
                    .fontWeight(.bold)
                
                Circle()
                    .fill(Color.mint)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Text("\(String(format: "%.0f", model.calculateCookTime(for: selectedDate))) min")
                    )
                    .font(.title)
                    .fontWeight(.bold)
            }
            .padding()
            .background(Color.black.edgesIgnoringSafeArea(.all))
            .sheet(isPresented: $showRecipePicker) {
                if let mealType = selectedMealType,
                   let favorites = storedFavorites.first?.favoriteRecipes,
                   !favorites.isEmpty {
                    RecipePickerView(recipes: favorites, mealType: mealType, model: model){ selectedRecipe in
                        model.assignMeal(for: selectedDate, mealType: mealType, recipe: selectedRecipe)
                        showRecipePicker = false
                    }
                }
                else {
                    Text("No favorite recipes available")
                }
            }
        }
    }

    // Helper function to create a meal section
    private func mealSection(mealType: MealType) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack(spacing: 15) {
                Image(systemName: mealType.iconName)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                
                Text(mealType.title)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Spacer()
            }

            if let meal = model.getMeal(for: selectedDate, mealType: mealType.rawValue) {
                HStack { // Display selected meal
                    URLImage(urlString: meal.image)
                        .frame(width: 50, height: 50)
                        .cornerRadius(10)
                    
                    Text(meal.name)
                        .font(.headline)
                        .foregroundColor(.white)
                }
            } else {
                // Placeholder when no meal is selected
                Text("Add \(mealType.title.lowercased()) here")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
        }
        .padding()
        .background(Color.mint)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
        .onTapGesture {
            selectedMealType = mealType.rawValue
            showRecipePicker = true
        }
        .onChange(of: showRecipePicker) { newValue in
            if !newValue {
                selectedMealType = nil
            }
        }
    }
}

