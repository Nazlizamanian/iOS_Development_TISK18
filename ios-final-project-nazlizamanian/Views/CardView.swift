//
//  CardView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI
import SwiftData

/*
 Sources used in this file:
 2.) Swipe card logic: https://www.youtube.com/watch?v=O2JXv9BnE70&t=311s
 */
import SwiftUI
import SwiftData

/*
 Sources used in this file:
 2.) Swipe card logic: https://www.youtube.com/watch?v=O2JXv9BnE70&t=311s
 */
struct CardView: View {
    @Environment(MealsModel.self) var model
    @Environment(\.modelContext) var modelContext
  
    @State private var card = Card()
    @State private var selectedDifficulty = "All"
    
    @Query private var favorites: [FavoriteRecipes]
    
    var filteredRecipes: [Recipe] {
        let recipes: [Recipe]
        
        switch selectedDifficulty {
        case "Easy":
            recipes = model.filterRecipes(byDifficulties: ["easy"])
        case "Medium":
            recipes = model.filterRecipes(byDifficulties: ["medium"])
        default:
            recipes = model.courses
        }
        return recipes
    }

    var body: some View {
        VStack {
            Picker("Difficulty", selection: $selectedDifficulty) {
                Text("All").tag("All")
                Text("Easy").tag("Easy")
                Text("Medium").tag("Medium")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()

            ZStack {
                if card.currentIndex < filteredRecipes.count {
                    ForEach(Array(filteredRecipes.enumerated()), id: \.element.id) { index, recipe in
                        if index == card.currentIndex {
                            ZStack(alignment: .bottomLeading) {
                                URLImage(urlString: recipe.image)
                                    .frame(width: 375, height: 600)
                                    .cornerRadius(20)
                                    .clipped()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(x: card.offset.width, y: card.cardOffset.height)
                                    .rotationEffect(.degrees(Double(card.offset.width / 20)))
                                    .gesture(
                                        DragGesture()
                                            .onChanged { gesture in
                                                if abs(gesture.translation.width) > abs(gesture.translation.height) {
                                                    card.offset = gesture.translation
                                                } else {
                                                    card.cardOffset.height = gesture.translation.height
                                                }
                                            }
                                            .onEnded { _ in
                                                withAnimation {
                                                    if card.offset.width < -100 {
                                                        card.moveToNextCard()
                                                    } else if card.offset.width > 100 {
                                                        
                                                        let favoriteList: FavoriteRecipes
                                                        
                                                        if let existingFavorites = favorites.first {
                                                            favoriteList = existingFavorites
                                                        }
                                                        else {
                                                            favoriteList = FavoriteRecipes()
                                                            modelContext.insert(favoriteList)
                                                        }
                                                        let currentRecipe = filteredRecipes[card.currentIndex]
                                                        model.addToFavorites(recipe: currentRecipe, favoriteRecipes: favoriteList, context: modelContext)
                                                        card.moveToNextCard()
                                                        
                                                    } else {
                                                        card.offset = .zero
                                                    }
                                                    
                                                    if card.cardOffset.height < -100 {
                                                        card.showDetails = true
                                                        card.cardOffset.height = -350
                                                    } else {
                                                        card.showDetails = false
                                                        card.cardOffset.height = .zero
                                                    }
                                                }
                                            }
                                    )

                                if card.showDetails {
                                    DetailsOverlay(recipe: recipe)
                                        .transition(.move(edge: .bottom))
                                }
                                
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        withAnimation {
                                            card.moveToNextCard()
                                        }
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .frame(width: 75, height: 75)
                                            .foregroundColor(.red)
                                            .padding(5)
                                    }
                                  
                                    Spacer()
                                    
                                    Button(action: {
                                        withAnimation {
                                            let favoriteList: FavoriteRecipes
                                            if let existingFavorites = favorites.first {
                                                favoriteList = existingFavorites
                                            }
                                            else {
                                                favoriteList = FavoriteRecipes()
                                                modelContext.insert(favoriteList)
                                            }
                                            let currentRecipe = filteredRecipes[card.currentIndex]
                                            model.addToFavorites(recipe: currentRecipe, favoriteRecipes: favoriteList, context: modelContext)

                                            card.moveToNextCard()
                                        }
                                    }) {
                                        Image(systemName: "heart.circle.fill")
                                            .resizable()
                                            .frame(width: 75, height: 75)
                                            .foregroundColor(.green)
                                            .padding(5)
                                    }
                                    Spacer()
                                }
                                .padding(.horizontal, 40)
                                .padding(.bottom, 20)
                            }
                            .zIndex(Double(model.courses.count - index))
                        }
                    }
                }
            }
            .padding()
            .onAppear { model.fetch() }
        }
    }
}
