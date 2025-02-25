//
//  MealsModelTests.swift
//  ios-final-project-nazlizamanianTests
//
//  Created by Nazli  on 17/02/25.
//

import Testing
import Foundation //for date()
@testable import ios_final_project_nazlizamanian

class MealsModelTests {
    
    @Test("test calculateCalories()")
    func testCalculateCalories() {
        // Arrange
        let model = MealsModel()
        let date = Date()
        
        // Create test recipes
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
            image: "image2",
            difficulty: "Medium",
            rating: 4.0,
            cuisine: "Mexican",
            prepTimeMinutes: 15,
            cookTimeMinutes: 25,
            servings: 2,
            caloriesPerServing: 500,
            reviewCount: 50
        )
        
        // Assign recipes to the date
        model.assignMeal(for: date, mealType: "Breakfast", recipe: recipe1)
        model.assignMeal(for: date, mealType: "Lunch", recipe: recipe2)
        
        // Act
        let totalCalories = model.calculateCalories(for: date)
        
        // Assert
        #expect(totalCalories == 1)
       
    }
    
    @Test("Test calculateCookTime()")
    func testCalculateCookTime() {
        // Arrange
        let model = MealsModel()
        let date = Date()
        
        // Create test recipes
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
            image: "image2",
            difficulty: "Medium",
            rating: 4.0,
            cuisine: "Mexican",
            prepTimeMinutes: 15,
            cookTimeMinutes: 25,
            servings: 2,
            caloriesPerServing: 500,
            reviewCount: 50
        )
        
        // Assign recipes to the date
        model.assignMeal(for: date, mealType: "Breakfast", recipe: recipe1)
        model.assignMeal(for: date, mealType: "Lunch", recipe: recipe2)
        
        // Act
        let totalCookTime = model.calculateCookTime(for: date)
        
        // Assert
        #expect(totalCookTime == 33.75)
    }
}
