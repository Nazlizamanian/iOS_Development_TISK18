//
//  DetailsOverlay.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 10/03/25.
//
import SwiftUI

struct DetailsOverlayView: View {
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
                        Text("\(String(format: "%.0f", recipe.prepTimeMinutes))m")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    Spacer()

                    VStack {
                        Text("Cook Time")
                            .foregroundColor(Color.gray)
                        Text("\(String(format: "%.0f", recipe.prepTimeMinutes))m")
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

                    Text(recipe.ingredients.map { $0.name }.joined(separator: ", "))
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

                    ForEach(recipe.instructions.map { $0.name }, id: \.self) { instruction in
                        Text(instruction)
                            .padding(.horizontal)
                            .padding(.bottom, 3)
                            .lineLimit(nil) // Allow full display
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .background(Color.black.opacity(0.4))
            .foregroundColor(.white)
            .cornerRadius(20)
            .padding(.top, 30)
            .shadow(radius: 10)
        }
        .frame(height: 400)
    }
}
