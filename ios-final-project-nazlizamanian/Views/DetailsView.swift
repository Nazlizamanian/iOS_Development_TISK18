//
//  DetailsView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 01/02/25.
//

import SwiftUI

struct DetailsView: View { //DetailScreen
    let meal: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                URLImage(urlString: meal.image)
                    .frame(width: 375, height: 400)
                    .cornerRadius(20)
                    .clipped()
                    .aspectRatio(contentMode: .fill)

                Text(meal.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                HStack {
                    ForEach(1...5, id: \.self) { index in
                        Image(systemName: index <= Int(meal.rating) ? "star.fill" : "star")
                            .foregroundColor(index <= Int(meal.rating) ? .yellow : .gray)
                            }
                    Text("(\(Int(meal.reviewCount)) Reviews)")
                        .foregroundColor(.gray)
                        }
                .padding(.leading, 10)

                HStack{
                    Spacer()
                    VStack {
                        Text("Prep Time")
                            .foregroundColor(Color.gray)
                        Text("\(meal.prepTimeMinutes)m")
                            .font(.title2)
                        .fontWeight(.bold)
                    }
                    Spacer()
                    
                    VStack {
                        Text("Cook Time")
                            .foregroundColor(Color.gray)
                        Text("\(meal.cookTimeMinutes)m")
                            .font(.title2)
                        .fontWeight(.bold)
                    }
                    Spacer()
                       
                }
                if !meal.ingredients.isEmpty {
                    Text("Ingredints")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                    
                    
                    Text(meal.ingredients.joined(separator: ", "))
                        .padding(.horizontal)
                        .padding(.bottom, 8)

                    
                }
                
                if !meal.instructions.isEmpty {
                    Text("Instructions")
                        .font(.headline)
                        .foregroundColor(Color.gray)
                        .padding(.horizontal)
                        .padding(.bottom, 4)
                    
                    ForEach(meal.instructions, id: \.self) { instruction in //Instructions is [] go thorugh all
                        Text(instruction)
                            .padding(.horizontal)
                            .padding(.bottom, 3)
                    }
                }
                
                Spacer()
            }
            .padding(.top)
        }
        .background(Color(.systemBackground))
        .navigationTitle(meal.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
