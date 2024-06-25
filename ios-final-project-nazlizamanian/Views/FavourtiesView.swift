//
//  FavourtiesView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI


struct URLImage: View { //Images  for each recipie
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

struct InstructionsView: View { //instructions for each recipe
    let instructions: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instructions:")
                .font(.subheadline)
            
            ForEach(instructions, id: \.self) { instruction in
                Text(instruction)
                    .padding(.leading, 10)
                    .padding(.top, 5)
            }
        }
        .padding(.top, 5)
    }
}

struct FavourtiesView: View {
    @State private var searchString = ""
    @State private var mealPages = []
    
   // @StateObject var viewModel = MealsModel()
    @EnvironmentObject var viewModel: MealsModel
    
    private var filteredRecipes: [Recipe] {
            guard !searchString.isEmpty else {
                return viewModel.favoriteRecipes
            }
            return viewModel.favoriteRecipes.filter { $0.name.lowercased().contains(searchString.lowercased()) }
        }
    
    var body: some View {
        NavigationStack { //navigationStack?
            List {
                
                    ForEach(filteredRecipes, id: \.self){ meals in
                        HStack{
                            URLImage(urlString: meals.image)
                            Text(meals.name)
                            /*InstructionsView(instructions: dish.instructions)
                                                     .padding(5)*/
                        }
                        .padding(3)
                    }
             
                    
            }
            .searchable(text: $searchString)
            .navigationTitle("Liked meals")
            .onAppear{
                viewModel.fetch()
            }
        }
    }
}

#Preview {
    FavourtiesView()
        .environmentObject(MealsModel())
}
