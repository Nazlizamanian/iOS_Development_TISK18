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
                ToolbarItem(placement: .navigationBarLeading){
                    NavigationLink(destination: StartPageView()){
                        Text("StartPage")
                    }
                    
                    
                   
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    NavigationLink(destination: FavourtiesView()){
                        Text("Fav")
                    }
                }
                    
                
            }
           .navigationBarBackButtonHidden(true) //döljer från content tbx t startPage
        .padding()
    }
}

#Preview {
    ContentView()
}
