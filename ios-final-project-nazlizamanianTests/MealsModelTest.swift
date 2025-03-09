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
    let recipe1 = Recipe(
        id: 1,
        name: "Recipe 1",
        ingredients: [
            Ingredient(name: "Pizza dough"),
            Ingredient(name: "Tomato sauce"),
            Ingredient(name: "Fresh mozzarella cheese"),
            Ingredient(name: "Fresh basil leaves"),
            Ingredient(name: "Olive oil"),
            Ingredient(name: "Salt and pepper to taste")
        ],
        instructions: [
            Instruction(name: "Preheat your oven to 450°F."),
            Instruction(name: "Spread the tomato sauce over the dough."),
            Instruction(name: "Add mozzarella, basil, olive oil, salt, and pepper."),
            Instruction(name: "Bake for 15 minutes until the crust is golden.")
        ],
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
            "Jasmine rice for serving"],
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
        ingredients: [
            "Ground lamb or beef",
            "Onions, grated",
            "Garlic, minced",
            "Parsley, finely chopped",
            "Cumin",
            "Coriander",
            "Red pepper flakes",
            "Salt and pepper to taste",
            "Flatbread for serving",
            "Tahini sauce"],
        instructions: ["Step 2"],
        image: "image1",
        difficulty: "Medium",
        rating: 4.9,
        cuisine: "American",
        prepTimeMinutes: 15,
        cookTimeMinutes: 10,
        servings: 24,
        caloriesPerServing: 150,
        reviewCount: 13
    )
    let mealsModel = MealsModel()
    let date1 = Day(date: Date())
    let date2 = Day(date: Date().addingTimeInterval(86400)) //next day
   
    
    @Test("Test calculateCalories()")
    func calculateCalories() async throws {
        
        //Act
        let meal1 = Meal(type: .breakfast, recipe: recipe1, day: date1)
        let meal2 = Meal(type: .lunch, recipe: recipe2, day: date1)
        
        let meal3 = Meal(type: .dinner, recipe: recipe3, day: date2)
        let meal4 = Meal(type: .snacks, recipe: recipe2, day: date2)
        
       
        date1.meals.append(contentsOf: [meal1, meal2])
        date2.meals.append(contentsOf: [meal3, meal4])
        
        let totalCalDay1 = mealsModel.calculateCalories(for: date1)
        let totalCalDay2 = mealsModel.calculateCalories(for: date2)
        
       //Assert
        #expect(totalCalDay1 == 600)
        #expect(totalCalDay1 != 0 && totalCalDay2 != 0)
        #expect(totalCalDay2 == 450)
    }
    
    
    @Test("calculateCookTime()")
    func calculateCookTime() async throws {
         //Act
         let meal1 = Meal(type: .breakfast, recipe: recipe1, day: date1)
         let meal2 = Meal(type: .lunch, recipe: recipe2, day: date1)
         
         let meal3 = Meal(type: .dinner, recipe: recipe3, day: date2)
         let meal4 = Meal(type: .snacks, recipe: recipe2, day: date2)
        
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
