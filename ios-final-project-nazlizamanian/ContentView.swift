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
        VStack {
            Text("Foodie!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
