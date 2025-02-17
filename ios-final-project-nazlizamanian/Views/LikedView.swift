//
//  FavourtiesView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI
import SwiftData

/*
 Source used in this file:
 3. NavigationStack: https://pixelkind.github.io/iOS-development/chapter3/navigationstack/
 */


struct LikedView: View {
    @State private var searchString = ""
    @Environment(MealsModel.self) var model
    
    @Environment(\.modelContext) var modelContext
  //  @Query private var recipeFavList: [RecipeFavList] //Swift persistance
    @State private var mealPages = []
    
    
    //@EnvironmentObject var model: MealsModel
    
    private var filteredRecipes: [Recipe] {
        guard !searchString.isEmpty else {
            return model.favoriteRecipes
        }
       // modelContext.insert()
        return model.favoriteRecipes.filter { $0.name.lowercased().contains(searchString.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
               
                List {
                    ForEach(filteredRecipes) { meal in
                        NavigationLink(destination: DetailsView(meal: meal)) {
                            HStack {
                                URLImage(urlString: meal.image)
                                    .frame(width: 140, height: 70)
                                    .scaledToFill()
                                
                                Text(meal.name)
                            }
                            .padding(3)
                        }
                      
                    }
                }
                .searchable(text: $searchString)
                .navigationTitle("Liked meals")
                .onAppear {
                    model.fetch()
                }
            }
        }
    }

}

