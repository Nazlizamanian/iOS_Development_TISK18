//
//  ContentView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = MealsModel()
    
    var body: some View {
            VStack{
                Text("Foodie!")
                   
            }
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarLeading){
                    NavigationLink(destination: StartPageView()){
                        Text("StartPage")
                    }
                    
                   
                }
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    NavigationLink(destination: FavourtiesView()){
                        Text("Fav")
                    }
                }
                    
                
            }
            .navigationBarBackButtonHidden(true)
        .padding()
    }
}

#Preview {
    ContentView()
}
