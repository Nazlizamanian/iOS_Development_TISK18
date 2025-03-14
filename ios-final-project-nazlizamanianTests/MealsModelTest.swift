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
            Ingredient(name: "Chicken thighs, boneless and skinless"),
            Ingredient(name: "Green curry paste"),
            Ingredient(name: "Coconut milk"),
            Ingredient(name: "Fish sauce"),
            Ingredient(name: "Sugar"),
            Ingredient(name: "Eggplant, sliced"),
            Ingredient(name: "Bell peppers, sliced"),
            Ingredient(name: "Basil leaves"),
            Ingredient(name: "Jasmine rice for serving")],
        instructions: [
            Instruction(name: "Marinate the chicken thighs with green curry paste and a splash of fish sauce for 15 minutes."),
            Instruction(name: "In a large pot, heat the coconut milk."),
            Instruction(name: "Add the marinated chicken and cook until it's browned on all sides."),
            Instruction( name: "Stir in the sliced eggplant and let the mixture simmer."),
            Instruction(name: "Adjust the seasoning with a bit fish sauce if needed."),
        ],
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
            Ingredient(name: "Ground lamb or beef"),
            Ingredient(name: "Onions, grated"),
            Ingredient(name: "Garlic, minced"),
            Ingredient(name: "Parsley, finely chopped"),
            Ingredient(name: "Cumin"),
            Ingredient(name: "Coriander"),
            Ingredient(name: "Red pepper flakes"),
            Ingredient(name: "Salt and pepper to taste"),
            Ingredient(name: "Flatbread for serving"),
            Ingredient(name: "Tahini sauce")
        ],
        instructions: [
            Instruction(name: "In a large bowl, combine the ground meat with the grated onions, minced garlic, and finely chopped parsley."),
            Instruction(name: "Sprinkle in the spices: cumin, coriander, red pepper flakes, salt, and pepper."),
            Instruction(name: "Mix everything thoroughly until the spices and aromatics are evenly distributed through the meat."),
        ],
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
        
        date1.meals.append(contentsOf: [meal1, meal2])
        date2.meals.append(contentsOf: [meal3, meal4])
        
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
        
        let containsMeatInRecipe1 = recipe1.ingredients.map {$0.name}
        let result1 = mealsModel.containsMeat(ingredients: containsMeatInRecipe1)
        
        let containsMeatInRecipe2 = recipe2.ingredients.map {$0.name}
        let result2 = mealsModel.containsMeat(ingredients: containsMeatInRecipe2)
        
        let containsMeatInRecipe3 = recipe3.ingredients.map {$0.name}
        let result3 = mealsModel.containsMeat(ingredients: containsMeatInRecipe3)
         
         // Assert
         #expect(result1  == false)
         #expect(result2 == true)
         #expect(result3 == true)
    }
    @Test("containsAllargen()")
    func containsAllaergen() async throws {
        //Act
        let ingridientsRecipe1 = recipe1.ingredients.map{$0.name}
        let detectedAllargensRecip1 = mealsModel.containsAllergens(ingredients: ingridientsRecipe1)
        
        //Assert
        #expect(detectedAllargensRecip1.contains(.gluten))
        #expect(detectedAllargensRecip1.contains(.dairy))
        #expect(!detectedAllargensRecip1.contains(.peanut))
    }
                
    /*@Test(" genereateDaysForMonth()") onödign
    func generateDaysForMonth() async throws {
        let calendarHelper = CalendarHelper()
        
        guard let febraryDate = DateFormatter().date(from: "2024-02-01") else { return }
        //leap year for febraru was 2024
        calendarHelper.currentDate = febraryDate
        let daysInFeb = calendarHelper.generateDaysForMonth()
         
        let expectedInFeb = 29
        #expect(daysInFeb.count == expectedInFeb)
        #expect(daysInFeb.last == 29)
    }*/
        
}
