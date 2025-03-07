//
//  FavourtiesView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI
import SwiftData


/*Source used in this file:
 3. NavigationStack: https://pixelkind.github.io/iOS-development/chapter3/navigationstack/
 4. SwipeButton: https://www.hackingwithswift.com/quick-start/swiftui/how-to-add-custom-swipe-action-buttons-to-a-list-row
 */

struct LikedView: View {
    @State private var searchString: String = ""
    @Query private var favorites: [FavoriteRecipes]
    

    @Environment(\.modelContext) private var modelContext
    @Environment(MealsModel.self) var model
    
    var filteredRecipes: [Recipe] {
        guard let favoriteList = favorites.first else { return [] }
        if searchString.isEmpty {
            return favoriteList.favoriteRecipes
        } else {
            return favoriteList.favoriteRecipes.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredRecipes){ meal in
                NavigationLink(destination: DetailsView(meal: meal)){
                    HStack{
                        URLImage(urlString: meal.image)
                            .frame(width: 140, height: 70)
                            .scaledToFill()
                        
                        Text(meal.name)
                    }
                    .padding(3)
                }
                .swipeActions(edge: .trailing, allowsFullSwipe: true){ //4
                    Button(role: .destructive){
                        guard let favoriteList = favorites.first else { return }
                        model.removeFromFavorites(recipe: meal, favoriteRecipes: favoriteList, context: modelContext)
                    } label: {
                        Label("Remove", systemImage: "trash")
                    }
                }
            }
            .searchable(text: $searchString)
            .navigationTitle("Liked meals")
        }
    }
}
