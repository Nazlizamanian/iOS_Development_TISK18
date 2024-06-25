//
//  ios_final_project_nazlizamanianApp.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

@main
struct ios_final_project_nazlizamanianApp: App {
    @StateObject private var model = MealsModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(MealsModel())
        }
    }
}
