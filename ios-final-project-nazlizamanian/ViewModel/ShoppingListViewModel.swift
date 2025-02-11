//
//  ShoppingListViewModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import Foundation
import SwiftUI

class ShoppingListViewModel: ObservableObject {
    @Published var shoppingList: [String] = [] // Holds ingredients
    
    func addIngredients(_ ingredients: [String]) {
        for ingredient in ingredients {
            if !shoppingList.contains(ingredient) { // Avoid duplicates
                shoppingList.append(ingredient)
            }
        }
    }

    func removeIngredient(_ ingredient: String) {
        shoppingList.removeAll { $0 == ingredient }
    }

    func clearList() {
        shoppingList.removeAll()
    }
}
