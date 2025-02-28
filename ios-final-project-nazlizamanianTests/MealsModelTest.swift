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
    
    //Arrange
    let mealsModel = MealsModel()
    let recipe1 = Recipe(
        id: 1,
        name: "Recipe 1",
        ingredients: [
            "Pizza dough",
            "Tomato sauce",
            "Fresh mozzarella cheese",
            "Fresh basil leaves",
            "Olive oil",
            "Salt and pepper to taste"
          ],
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
        ingredients: [
            "Chicken thighs, boneless and skinless",
            "Green curry paste",
            "Coconut milk",
            "Fish sauce",
            "Sugar",
            "Eggplant, sliced",
            "Bell peppers, sliced",
            "Basil leaves",
            "Jasmine rice for serving"
          ],
        instructions: ["Step 2"],
        image: "image1",
        difficulty: "Medium",
        rating: 4.5,
        cuisine: "Italian",
        prepTimeMinutes: 15,
        cookTimeMinutes: 20,
        servings: 3,
        caloriesPerServing: 300,
        reviewCount: 100
        )
    
    let recipe3 = Recipe(
        id: 3,
        name: "Recipe 3",
        ingredients:  [
            "Ground lamb or beef",
            "Onions, grated",
            "Garlic, minced",
            "Parsley, finely chopped",
            "Cumin",
            "Coriander",
            "Red pepper flakes",
            "Salt and pepper to taste",
            "Flatbread for serving",
            "Tahini sauce"
          ],
        instructions: ["Step 2"],
        image: "image1",
        difficulty: "Easy",
        rating: 4.9,
        cuisine: "American",
        prepTimeMinutes: 15,
        cookTimeMinutes: 10,
        servings: 24,
        caloriesPerServing: 150,
        reviewCount: 13
        )

    
    let date1 = Date()
    let date2 = Date().addingTimeInterval(86400) // next day
    
    @Test("Test calculateCalories()")
    func calculateCalories() async throws {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions
    
        //Act
        mealsModel.courses = [recipe1, recipe2, recipe3]
        
        mealsModel.assignMeal(for: date1, mealType: "Breakfast", recipe: recipe1)
        mealsModel.assignMeal(for: date1, mealType: "Lunch", recipe: recipe2)
        mealsModel.assignMeal(for: date2, mealType: "Dinner", recipe: recipe3)
        
        let totalCalDay1 = mealsModel.calculateCalories(for: date1)
        let totalCalDay2 = mealsModel.calculateCalories(for: date2)
        
        let expectedCal = recipe1.caloriesPerServing + recipe2.caloriesPerServing
    
        //Assert
        #expect(totalCalDay1 == expectedCal)
        #expect(totalCalDay1 != 0 && expectedCal != 0  && totalCalDay2 != 0)
        #expect( totalCalDay1 != totalCalDay2)
       
    }
    
    @Test("calculateCookTime()")
    func calculateCookTime() async throws {
        
        //Act
        mealsModel.assignMeal(for: date1, mealType: "Breakfast", recipe: recipe1)
        mealsModel.assignMeal(for: date1, mealType: "Lunch", recipe: recipe2)
        mealsModel.assignMeal(for: date2, mealType: "Snacks", recipe: recipe3)
        
        let totalCookTimeDay1 = mealsModel.calculateCookTime(for: date1)
        let totalCookTimeDay2 = mealsModel.calculateCookTime(for: date2)
        
        let prepTime1 = (recipe1.prepTimeMinutes / Double(recipe1.servings))
        let prepTime2 = (recipe2.prepTimeMinutes / Double(recipe2.servings))
        
        //Assert
        #expect(prepTime1 != 0 && prepTime2 != 0)
        #expect(totalCookTimeDay1 == 45.0)  //20 + 5+20= 45.0
        #expect(totalCookTimeDay1 != totalCookTimeDay2)
    }

    @Test(" containsMeat()")
     func containsMeath() async throws {
        let containsMeatInRecipe1 = mealsModel.containsMeat(ingredients: recipe1.ingredients)
        let containsMeatInRecipe2 = mealsModel.containsMeat(ingredients: recipe2.ingredients)
        let containsMeatInRecipe3 = mealsModel.containsMeat(ingredients: recipe3.ingredients)
                 
        // Assert
        #expect(containsMeatInRecipe1 == false)
        #expect(containsMeatInRecipe2 == true)
        #expect(containsMeatInRecipe3 == true)
     }
    
    
   @Test(" genereateDaysForMonth()")
    func generateDaysForMonth() async throws {
        let calendarHelper = CalendarHelper()
        
        guard let febraryDate = DateFormatter().date(from: "2024-02-01") else { return }
        //leap year for febraru was 2024
        
        calendarHelper.currentDate = febraryDate
        let daysInFeb = calendarHelper.generateDaysForMonth()
        
        let expectedInFeb = 29
        #expect(daysInFeb.count == expectedInFeb)
        #expect(daysInFeb.last == 29)
    }
    
    
}
