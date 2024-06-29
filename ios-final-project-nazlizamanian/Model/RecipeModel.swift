//
//  RecipeModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 29/06/24.
//

import Foundation
import SwiftData

/**Model**/
struct Recipe: Codable, Hashable, Identifiable{
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let image: String
    let difficulty: String
    let rating: Double
    let cuisine: String
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let reviewCount: Int
}


struct RecipesResponse: Codable {
    let recipes: [Recipe]
}

@Model
final class RecipeFavList{
    @Attribute(.unique) let id: Int
    let name: String
    let image: String
    
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
    }
}
