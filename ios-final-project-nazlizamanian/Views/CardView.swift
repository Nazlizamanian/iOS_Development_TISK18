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


//Todo: fix bug logic what happens if you swipped on all cards?
struct CardView: View {
    @EnvironmentObject var model: MealsModel
    @StateObject private var card = Card() //Card instance of our model handles logci
    @State private var selectedDifficulty = "All"

    
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
                                    .offset(x: card.offset.width, y: card.cardOffset.height) // Moves horizontally and vertically
                                    .rotationEffect(.degrees(Double(card.offset.width / 20))) // Slight rotation effect
                                    .gesture(
                                        DragGesture()
                                            .onChanged { gesture in
                                                if abs(gesture.translation.width) > abs(gesture.translation.height) {
                                                    // Horizontal swipe (left/right)
                                                    card.offset = gesture.translation
                                                } else {
                                                    // Vertical swipe (up/down)
                                                    card.cardOffset.height = gesture.translation.height
                                                }
                                            }
                                            .onEnded { _ in
                                                withAnimation {
                                                    // Handle horizontal swipe (left/right)
                                                    if card.offset.width < -100 {
                                                        // Swiped left
                                                        card.moveToNextCard()
                                                    } else if card.offset.width > 100 {
                                                        // Swiped right (liked)
                                                        model.addToFavorites(recipe: filteredRecipes[card.currentIndex])
                                                        card.moveToNextCard()
                                                    } else {
                                                        card.offset = .zero
                                                    }

                                                    // Handle vertical swipe (up/down)
                                                    if card.cardOffset.height < -100 {
                                                        // Swipe up to show details
                                                        card.showDetails = true
                                                        card.cardOffset.height = -350 // Move image up
                                                    } else {
                                                        // Reset details view
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
                                HStack { //Buttons
                                    Spacer()
                                    Button(action: { withAnimation { card.swipeCard(width: -200, filteredRecipes: filteredRecipes, model: model) } }) {
                                        Image(systemName: "xmark")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.red)
                                            .padding(14)
                                    }
                                    .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.red, lineWidth: 2))
                                    Spacer()
                                    Button(action: { withAnimation { card.swipeCard(width: 200, filteredRecipes: filteredRecipes, model: model) } }) {
                                        Image(systemName: "heart.fill")
                                            .resizable()
                                            .frame(width: 30, height: 30)
                                            .foregroundColor(.green)
                                            .padding(14)
                                    }
                                    
                                    .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.green, lineWidth: 2))
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
