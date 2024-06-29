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
            NavigationStack{
                StartPageView()
                
            }
            .navigationTitle("StartPageview")
            /*
            NavigationStack{
                NavigationStack {
                    VStack {
                        NavigationLink("Go to Card", value: Destination.card)
                        NavigationLink("Go to Fav", value: Destination.fav)

                    }
                    .navigationDestination(for: Destination.self) { destination in
                        switch destination {
                        case .card:
                            CardView()
                        case .fav:
                            FavourtiesView()

                        }
                    }
                }
                .environmentObject(viewModel)


            }*/
        }
    }


    enum Destination: Hashable{
            case card
            case fav
    }


    #Preview {
        ContentView()
            .environmentObject(MealsModel())
    }


    /*
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                NavigationLink(destination: StartPageView()){
                    Text("StartPage")
                }
               
            }
            ToolbarItem(placement: .navigationBarLeading){
                NavigationLink(destination: CardView()){
                    Text("CardView")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing){
                NavigationLink(destination: FavourtiesView()){
                    Text("Fav")
                }
            }
                
            
        }
       .navigationBarBackButtonHidden(true) //döljer från content tbx t startPage*/
