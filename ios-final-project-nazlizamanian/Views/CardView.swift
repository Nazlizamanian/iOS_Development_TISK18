//
//  CardView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

/*
 Sources used in this file:
 1.) Swipe card logic: https://www.youtube.com/watch?v=O2JXv9BnE70&t=311s
 */
struct URLImage: View {
    let urlString: String
    @State private var imageData: Data?

    var body: some View {
        GeometryReader { geometry in
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    
            } else {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .onAppear { fetchData() }
            }
        }
    }

    private func fetchData() {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async { self.imageData = data }
        }.resume()
    }
}



struct CardView: View {
    @EnvironmentObject var model: MealsModel
    @State private var offset = CGSize.zero // Tracks horizontal swipes (left/right)
    @State private var cardOffset = CGSize.zero // Tracks vertical movement (up/down)
    @State private var showDetails = false // Controls whether details are shown
    @State private var currentIndex: Int = 0
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
                if currentIndex < filteredRecipes.count {
                    ForEach(Array(filteredRecipes.enumerated()), id: \.element.id) { index, recipe in
                        if index == currentIndex { //Visa bara  ett recipet i taget
                            ZStack(alignment: .bottomLeading) {
                                URLImage(urlString: recipe.image)
                                    .frame(width: 375, height: 600)
                                    .cornerRadius(20)
                                    .clipped()
                                    .aspectRatio(contentMode: .fill)
                                    .offset(x: offset.width, y: cardOffset.height) // Moves horizontally and vertically
                                    .rotationEffect(.degrees(Double(offset.width / 20))) // Slight rotation effect
                                    .gesture(
                                        DragGesture()
                                            .onChanged { gesture in
                                                if abs(gesture.translation.width) > abs(gesture.translation.height) {
                                                    // Horizontal swipe (left/right)
                                                    offset = gesture.translation
                                                } else {
                                                    // Vertical swipe (up/down)
                                                    cardOffset.height = gesture.translation.height
                                                }
                                            }
                                            .onEnded { _ in
                                                withAnimation {
                                                    // Handle horizontal swipe (left/right)
                                                    if offset.width < -100 {
                                                        // Swiped left
                                                        moveToNextCard()
                                                    } else if offset.width > 100 {
                                                        // Swiped right (liked)
                                                        model.addToFavorites(recipe: filteredRecipes[currentIndex])
                                                        moveToNextCard()
                                                    } else {
                                                        offset = .zero
                                                    }

                                                    // Handle vertical swipe (up/down)
                                                    if cardOffset.height < -100 {
                                                        // Swipe up to show details
                                                        showDetails = true
                                                        cardOffset.height = -350 // Move image up
                                                    } else {
                                                        // Reset details view
                                                        showDetails = false
                                                        cardOffset.height = .zero
                                                    }
                                                }
                                            }
                                    )

                                if showDetails {
                                    DetailsOverlay(recipe: recipe)
                                        .transition(.move(edge: .bottom))
                                }
                            }
                            .zIndex(Double(model.courses.count - index))
                        }
                    }
                }
            }
            .padding()
            .onAppear { model.fetch() }

            HStack {
                Spacer()
                Button(action: { withAnimation { swipeCard(width: -200) } }) {
                    Image(systemName: "xmark")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.red)
                        .padding(14)
                }
                .overlay(RoundedRectangle(cornerRadius: 40).stroke(Color.red, lineWidth: 2))
                Spacer()
                Button(action: { withAnimation { swipeCard(width: 200) } }) {
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
        }
    }

    // Function for button-based swiping
    private func swipeCard(width: CGFloat) {
        withAnimation {
            if width < -150 {
                moveToNextCard()
            } else if width > 150 {
                if currentIndex < filteredRecipes.count {
                    let likedRecipe = filteredRecipes[currentIndex] // Ensure we reference the correct recipe
                    model.addToFavorites(recipe: likedRecipe) // Add before moving to the next card
                }
                moveToNextCard()
            }
        }
    }

    // Move to the next card after a swipe
    private func moveToNextCard() {
        withAnimation {
            currentIndex += 1
            offset = .zero
            cardOffset = .zero
            showDetails = false
        }
    }
}
struct DetailsOverlay: View {
    var recipe: Recipe

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text(recipe.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .lineLimit(nil)

                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= Int(recipe.rating) ? "star.fill" : "star")
                            .foregroundColor(index <= Int(recipe.rating) ? .yellow : .gray)
                    }
                    Text("(\(Int(recipe.reviewCount)) Reviews)")
                        .foregroundColor(.gray)
                }
                .padding(.leading, 10)

                HStack {
                    Spacer()
                    VStack {
                        Text("Prep Time")
                            .foregroundColor(Color.gray)
                        Text("\(recipe.prepTimeMinutes)m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()

                    VStack {
                        Text("Cook Time")
                            .foregroundColor(Color.gray)
                        Text("\(recipe.cookTimeMinutes)m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()
                }
                .padding(.horizontal)

                if !recipe.ingredients.isEmpty {
                    Text("Ingredients")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)

                    Text(recipe.ingredients.joined(separator: ", "))
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                        .lineLimit(nil)
                }

                if !recipe.instructions.isEmpty {
                    Text("Instructions")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)

                    ForEach(recipe.instructions, id: \.self) { instruction in
                        Text(instruction)
                            .padding(.horizontal)
                            .padding(.bottom, 3)
                            .lineLimit(nil) // Allow full display
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.4))
            .cornerRadius(20)
            .padding(.top, 30)
            .shadow(radius: 10)
        }
        .frame(height: 400)
    }
}
