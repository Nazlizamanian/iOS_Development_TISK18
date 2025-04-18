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

struct CardView: View {
    @Environment(MealsModel.self) var model
    @Environment(\.modelContext) var modelContext
  
    @State private var card = Card()
    @State private var selectedDifficulty = "All"
    @State private var shuffledRecipes: [Recipe] = [] // Store shuffled recipes
    @State private var isDataLoaded = false // Track if data has been fetched

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
            // Difficulty Picker
            Picker("Difficulty", selection: $selectedDifficulty) {
                Text("All").tag("All")
                Text("Easy").tag("Easy")
                Text("Medium").tag("Medium")
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            .onChange(of: selectedDifficulty) { _, _ in
                // Shuffle recipes when difficulty changes
                shuffledRecipes = filteredRecipes.shuffled()
                card.currentIndex = 0
            }

            // Card Stack
            ZStack {
                if card.currentIndex < shuffledRecipes.count {
                    ForEach(Array(shuffledRecipes.enumerated()), id: \.element.id) { index, recipe in
                        if index == card.currentIndex {
                            ZStack(alignment: .bottomLeading) {
                                URLImage(urlString: recipe.image)
                                    .frame(width: 375, height: 600)
                                    .cornerRadius(20)
                                    .clipped()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(x: card.offset.width, y: card.cardOffset.height)
                                    .rotationEffect(.degrees(Double(card.offset.width / 30)))
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
                                                    if card.offset.width < -100 { //left
                                                        card.moveToNextCard()
                                                        
                                                    } else if card.offset.width > 100 { //right
                                                        model.addToFavorites(recipe: shuffledRecipes[card.currentIndex], favorites: favorites, modelContext: modelContext)
                                                        card.moveToNextCard()
                                                    } else {
                                                        card.offset = .zero
                                                    }
                                                    if card.cardOffset.height < -100 { //details
                                                        card.showDetails = true
                                                        card.cardOffset.height = -350
                                                    } else {
                                                        card.showDetails = false
                                                        card.cardOffset.height = .zero
                                                    }
                                                }
                                            }
                                    )

                                // Show details overlay
                                if card.showDetails {
                                    DetailsOverlayView(recipe: recipe)
                                        .transition(.move(edge: .bottom))
                                }
                                
                                // Swipe buttons
                                HStack {
                                    Spacer()
                                    Button {
                                        withAnimation {
                                            card.moveToNextCard()
                                        }
                                    } label: {
                                        Image(systemName: "xmark.circle.fill")
                                            .resizable()
                                            .frame(width: 75, height: 75)
                                            .foregroundColor(.red)
                                            .padding(5)
                                    }
                                  
                                    Spacer()
                                    
                                    Button {
                                        withAnimation {
                                            model.addToFavorites(recipe: shuffledRecipes[card.currentIndex], favorites: favorites, modelContext: modelContext)
                                            card.moveToNextCard()
                                        }
                                    } label: {
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
                            .zIndex(Double(shuffledRecipes.count - index))
                        }
                    }
                } else if isDataLoaded && shuffledRecipes.isEmpty {
                    Text("No recipes available")
                        .font(.title)
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .onAppear {
                if !isDataLoaded {
                    Task{
                        await model.fetch()
                        shuffledRecipes = filteredRecipes.shuffled()
                        isDataLoaded = true //otherwise trigger re render ex if selectedDifficulity changes
                    }
                }
            }
        }
    }
    
    
}

