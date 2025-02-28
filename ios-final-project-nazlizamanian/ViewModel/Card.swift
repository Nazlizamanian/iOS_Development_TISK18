//
//  Card.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 15/02/25.
//
import Foundation
import SwiftUI
import Observation
import SwiftData

/*
 Sources used in this file:
 2.) Swipe card logic: https://www.youtube.com/watch?v=O2JXv9BnE70&t=311s
 logic connected to the cardview same sorce 
 */

@Observable
class Card  {
    var currentIndex: Int = 0
    var offset: CGSize = .zero
    var cardOffset = CGSize.zero
    var showDetails: Bool = false
    
    
    func moveToNextCard() {
        withAnimation {
            currentIndex += 1
            offset = .zero
            cardOffset = .zero
            showDetails = false
        }
    }
    
    func swipeCard(width: CGFloat, filteredRecipes: [Recipe], model: MealsModel, context: ModelContext) {
            withAnimation {
                if width < -150 {
                    moveToNextCard()
                    
                } else if width > 150 {
                    if currentIndex < filteredRecipes.count {
                        let likedRecipe = filteredRecipes[currentIndex]
                        model.addToFavorites(recipe: likedRecipe, in: context)
                    }
                    moveToNextCard()
                }
            }
        }
   
}
