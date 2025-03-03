//
//  CardView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

/*
 Sources used in this file:
 2.) Swipe card logic: https://www.youtube.com/watch?v=O2JXv9BnE70&t=311s
 */
struct CardView: View {
    @Environment(MealsModel.self) var model
    @Environment(\.modelContext) var modelContext
    
    @State private var card = Card() // Card instance handling logic
    @State private var selectedDifficulty = "All"
    
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
        return recipes.shuffled()
    }


    var body: some View {
        VStack {
            Picker("Difficulty", selection: $selectedDifficulty) {
                Text("All").tag("All")
                Text("Easy").tag("Easy")
                Text("Medium").tag("Medium")
            }
            .pickerStyle(SegmentedPickerStyle())

            ZStack {
                if card.currentIndex < filteredRecipes.count {
                    ForEach(Array(filteredRecipes.enumerated()), id: \.element.id) { index, recipe in
                        if index == card.currentIndex { // Only show one recipe at a time
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
                                                        // Swiped left
                                                        card.moveToNextCard()
                                                    } else if card.offset.width > 100 {
                                                        // Swiped right (liked)
                                                        let recipe = filteredRecipes[card.currentIndex]
                                                        model.addToFavorites(recipe: recipe, in: modelContext)
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
                                            // For dislike, simply call swipeCard (context is passed even though it's not used in the left branch)
                                            card.swipeCard(width: -200, filteredRecipes: filteredRecipes, model: model, context: modelContext)
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
                                            // Heart button now uses the same swipe logic for a "yes" (like)
                                            card.swipeCard(width: 200, filteredRecipes: filteredRecipes, model: model, context: modelContext)
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


