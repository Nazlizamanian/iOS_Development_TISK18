//
//  FavourtiesView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI


struct URLImage: View { //Images for each recipie
    let urlString: String
    
    @State var data: Data? //bcause data is state it going to redraw the view when it changes.
    
    var body: some View{
        if let data = data, let uiimage = UIImage(data: data){
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
        }
        else{
            Image(systemName:"video")
                .frame(width: 130, height: 70)
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
            VStack(alignment: .leading, spacing: 16) {
                
                URLImageView(urlString: meal.image)
                    .frame(width: 375, height: 400)
                    .cornerRadius(20)
                    .clipped()
                    .aspectRatio(contentMode: .fill)

                Text(meal.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                
                if !meal.instructions.isEmpty {
                    Text("Instructions:")
                        .font(.headline)
                        .padding(.horizontal)
                        .padding(.bottom, 8)
                    
                    ForEach(meal.instructions, id: \.self) { instruction in //Instructions is [] go thorugh all
                        Text(instruction)
                            .padding(.horizontal)
                            .padding(.bottom, 4)
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
