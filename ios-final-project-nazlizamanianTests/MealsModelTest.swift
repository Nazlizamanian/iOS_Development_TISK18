//
//  MealsModelTest.swift
//  ios-final-project-nazlizamanianTests
//
//  Created by Nazli  on 26/02/25.
//

import Testing
import Foundation //Date()

@testable import ios_final_project_nazlizamanian

struct MealsModelTest {
    
    
    @Test("Test calculateCalories")
    func calculateCalories() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
        //Arrange
        let mealsModel = MealsModel()
        let recipe1 = Recipe(
            id: 1,
            name: "Recipe 1",
            ingredients: ["Ingredient 1"],
            instructions: ["Step 1"],
            image: "image1",
            difficulty: "Easy",
            rating: 4.5,
            cuisine: "Italian",
            prepTimeMinutes: 10,
            cookTimeMinutes: 20,
            servings: 4,
            caloriesPerServing: 300,
            reviewCount: 100
            )
        
        let recipe2 = Recipe(
            id: 2,
            name: "Recipe 2",
            ingredients: ["Ingredient 2"],
            instructions: ["Step 2"],
            image: "image1",
            difficulty: "Easy",
            rating: 4.5,
            cuisine: "Italian",
            prepTimeMinutes: 10,
            cookTimeMinutes: 20,
            servings: 4,
            caloriesPerServing: 300,
            reviewCount: 100
            )
        
        //Act
        mealsModel.courses = [recipe1, recipe2]
        let date = Date()
        
        mealsModel.assignMeal(for: date, mealType: "Breakfast", recipe: recipe1)
        mealsModel.assignMeal(for: date, mealType: "Lunch", recipe: recipe2)
        
        let totalCal = mealsModel.calculateCalories(for: date)
        let expectedCal = recipe1.caloriesPerServing + recipe2.caloriesPerServing
    
        //Assert
        #expect(totalCal == expectedCal)
       
    }

}
