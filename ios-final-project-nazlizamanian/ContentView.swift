//
//  ContentView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

/*
 Soruces in this file:
 1. TabView: https://medium.com/mobile-app-experts/tabview-in-swiftui-082058488426
 */

struct ContentView: View {
    @State var viewModel = MealsModel() //stateobj init once and shared across or views
    
    @State private var selectedIndex: Int = 0

        var body: some View {
            TabView(selection: $selectedIndex){ //1
                NavigationStack(){
                    CardView()
                }
                .tabItem{
                    Label("Swipe", systemImage: "flame.fill")
                }
                .tag(0)
                
                NavigationStack(){ //liked list
                   LikedView()
                }
                .tabItem{
                    Label("Liked", systemImage: "heart.fill")
                }
                .tag(1)
                
                NavigationStack(){ //Visar claendar sidan
                    CalendarView()
                }
                .tabItem{
                    Label("Calendar", systemImage: "calendar")
                }
                .tag(2)
                
            }//Tabview
            .tint(.mint)
    }
}

