//
//  FavourtiesView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

/*
 Source used in this file:
 NavigationStack: https://pixelkind.github.io/iOS-development/chapter3/navigationstack/
 */
struct URLImage: View { //Images for each recipie
    let urlString: String
    
    @State var data: Data? //bcause data is state it going to redraw the view when it changes.
    
    var body: some View{
        if let data = data, let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 140, height: 70)
                .background(Color.gray)
        }
        else{
            Image(systemName:"video")
                .frame(width: 140, height: 70)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                    
                }
        }
    }
    private func fetchData(){
        guard let url = URL(string: urlString)else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){ data, _, _ in
            self.data = data
            
        }
        task.resume()
    }
    
    
}


struct DetailView: View { //DetailScreen
    let meal: Recipe
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                
                URLImageView(urlString: meal.image)
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


struct FavouritesView: View {
    @State private var searchString = ""
    @State private var mealPages = []
    
    @EnvironmentObject var viewModel: MealsModel
    
    private var filteredRecipes: [Recipe] {
        guard !searchString.isEmpty else {
            return viewModel.favoriteRecipes
        }
        return viewModel.favoriteRecipes.filter { $0.name.lowercased().contains(searchString.lowercased()) }
    }
    
    var body: some View {
        NavigationStack {
                List {
                    ForEach(filteredRecipes, id: \.self) { meal in
                        NavigationLink(destination: DetailView(meal: meal)) {
                            HStack {
                                URLImage(urlString: meal.image)
                                Text(meal.name)
                            }
                            .padding(3)
                        }
                    }
                }
                .searchable(text: $searchString)
                .navigationTitle("Liked meals")
                .onAppear {
                    viewModel.fetch()
                }
            
        }
    }
}


#Preview {
    FavouritesView()
        .environmentObject(MealsModel())
}
