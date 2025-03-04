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
 */

struct LikedView: View {
    @State private var searchString: String = ""
    @Query private var favorites: [FavoriteRecipes]

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
            }
            .searchable(text: $searchString)
            .navigationTitle("Liked meals")
        }
    }
}
