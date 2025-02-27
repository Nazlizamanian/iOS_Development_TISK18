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
        prepTimeMinutes: 20,
        cookTimeMinutes: 15,
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
        prepTimeMinutes: 15,
        cookTimeMinutes: 20,
        servings: 3,
        caloriesPerServing: 300,
        reviewCount: 100
        )
    let date = Date()
    
    @Test("Test calculateCalories")
    func calculateCalories() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        
        //Arrange
       
        
        //Act
        mealsModel.courses = [recipe1, recipe2]
        
        mealsModel.assignMeal(for: date, mealType: "Breakfast", recipe: recipe1)
        mealsModel.assignMeal(for: date, mealType: "Lunch", recipe: recipe2)
        
        let totalCal = mealsModel.calculateCalories(for: date)
        let expectedCal = recipe1.caloriesPerServing + recipe2.caloriesPerServing
    
        //Assert
        #expect(totalCal == expectedCal)
        #expect(totalCal != 0 && expectedCal != 0 )
       
    }
    
    @Test("calculateCookTime()")
    func calculateCookTime() async throws {
        
    
        mealsModel.assignMeal(for: date, mealType: "Breakfast", recipe: recipe1)
        mealsModel.assignMeal(for: date, mealType: "Lunch", recipe: recipe2)
        
        let totalCookTime = mealsModel.calculateCookTime(for: date)
        
        
        let prepTime1 = (recipe1.prepTimeMinutes / Double(recipe1.servings))
        let prepTime2 = (recipe2.prepTimeMinutes / Double(recipe2.servings))
        
        
        #expect( prepTime1 != 0 && prepTime2 != 0)
        #expect( totalCookTime == 45.0)  //20 + 5+20= 45.0
        
        
       
    }

    
}
