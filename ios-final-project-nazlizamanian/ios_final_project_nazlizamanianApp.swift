//
//  ios_final_project_nazlizamanianApp.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI
import SwiftData

@main
struct ios_final_project_nazlizamanianApp: App {
    
    @State private var model = MealsModel()
        
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(model) //inject global acess
                .modelContainer(for: [FavoriteRecipes.self, Day.self, Meal.self, Recipe.self])
        }
    }
}
