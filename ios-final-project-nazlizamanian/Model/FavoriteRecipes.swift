//
//  FavoriteRecipe.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/03/25.
//

import Foundation
import SwiftData

@Model
final class FavoriteRecipes {
    @Relationship(deleteRule: .cascade) var favoriteRecipes: [Recipe]
    
    init(favoriteRecipes: [Recipe] = []){
        self.favoriteRecipes = favoriteRecipes
    }
    
}
