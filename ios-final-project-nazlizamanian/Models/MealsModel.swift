//
//  MealsModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import Foundation
import SwiftUI

struct Recipes: Hashable, Codable {
    let id: Int
    let name: String
    let image: String
    
}

struct RecipesResponse: Codable {
    let recipes: [Recipes]
}


class MealsModel: ObservableObject {
    @Published var courses: [Recipes] = []
    
    func fetch(){ //Fetch data from our api
        guard let url = URL(string: "https://dummyjson.com/recipes?limit=49&select=name,image") else { return }
        
    }
}
