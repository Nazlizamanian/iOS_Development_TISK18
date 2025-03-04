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
    
    @Query private var favoriteRecipes: [FavoriteRecipes]
    
    @State private var showRecipePicker = false
    @State private var selectedMealType: MealType?
    @State private var day: Day?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text(selectedDate, format: .dateTime.weekday(.wide).day().month(.abbreviated))
                    .font(.largeTitle)
                    .bold()

                ForEach(MealType.allCases, id: \.self) { mealType in
                    let mealsForType = day?.meals.filter { $0.type == mealType } ?? []

                    VStack(alignment: .leading) {
                        Button {
                            selectedMealType = mealType
                            showRecipePicker = true
                        } label: {
                            HStack (spacing: 15){
                                Image(systemName: mealType.iconName)
                                    .font(.system(size: 30))
                                    .foregroundColor(.white)
                                
                                Text(mealType.title)
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Spacer()
                                
                                Image(systemName: "plus")
                                
                            }
                            .padding()
                        }
                        if !mealsForType.isEmpty {
                            
                            ForEach(mealsForType, id: \.id) { meal in
                                HStack(spacing: 15) {
                                    URLImage(urlString: meal.recipe.image)
                                        .frame(width: 50, height: 50)
                                        .cornerRadius(10)

                                    Text(meal.recipe.name)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                }
                                .padding([.leading, .bottom])
                            }
                        }
                    }
                    .background(Color.mint)
                    .cornerRadius(20)
                }
                Text("Total Cal: \(model.calculateCalories(for: day))")
                    .font(.title)
                    .fontWeight(.bold)
                
                Circle()
                    .fill(Color.mint)
                    .frame(width: 120, height: 120)
                    .overlay(
                        Text("Total Cook Time: \(model.calculateCookTime(for: day), specifier: "%.0f") min")
                            .font(.title3)
                            .fontWeight(.bold)

                    )
                    
            }
            .padding()
        }
        .onAppear {
            day = model.loadOrCreateDay(for: selectedDate, context: modelContext)
        }
        .sheet(isPresented: $showRecipePicker) {
            if let selectedMealType = selectedMealType {
                RecipePickerView(
                    mealType: selectedMealType,
                    day: day!,
                    favoriteRecipes: favoriteRecipes.first?.favoriteRecipes ?? [],
                    model: model
                )
            }
        }
    }
}
