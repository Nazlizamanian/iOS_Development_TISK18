//
//  CardViewModel.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import Foundation

class CardViewModel: ObservableObject {
    @Published var offset = CGSize.zero
    @Published var currentIndex = 0
    @Published var selectedDifficulty = "All"
    
    private var model: MealsModel
    
    init(model: MealsModel) {
        self.model = model
    }
    
    var filteredRecipes: [Recipe] {
        switch selectedDifficulty {
        case "Easy":
            return model.filterRecipes(byDifficulties: ["easy"])
        case "Medium":
            return model.filterRecipes(byDifficulties: ["medium"])
        default:
            return model.courses
        }
    }
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150): // Swipe left (Dislike)
            offset = CGSize(width: -500, height: 0)
            moveToNextCard()
            
        case 150...500: // Swipe right (Like)
            offset = CGSize(width: 500, height: 0)
            addToFavorites(recipe: filteredRecipes[currentIndex])
            moveToNextCard()
            
        default:
            offset = .zero
        }
    }
    
    private func moveToNextCard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.currentIndex += 1
            self.offset = .zero
        }
    }
    
    private func addToFavorites(recipe: Recipe) {
        model.addToFavorites(recipe: recipe)
    }
}
