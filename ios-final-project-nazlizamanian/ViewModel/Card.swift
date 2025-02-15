//
//  Card.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 15/02/25.
//
import Foundation
import SwiftUI

class Card: ObservableObject {
    @Published var currentIndex: Int = 0
    @Published var offset: CGSize = .zero
    @Published var cardOffset = CGSize.zero
    @Published var showDetails: Bool = false

    func moveToNextCard() {
        withAnimation {
            currentIndex += 1
            offset = .zero
            cardOffset = .zero
            showDetails = false
        }
    }
    
    func swipeCard(width: CGFloat, filteredRecipes: [Recipe], model: MealsModel){
        withAnimation{
            if width < -150 {
                moveToNextCard()
            }
            else if width > 150{
                if currentIndex < filteredRecipes.count{
                    let likedRecipe = filteredRecipes[currentIndex]
                    model.addToFavorites(recipe: likedRecipe)
                    
                }
                moveToNextCard()
            }
        }
    }
}
