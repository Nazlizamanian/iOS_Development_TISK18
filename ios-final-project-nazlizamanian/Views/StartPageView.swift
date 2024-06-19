//
//  StartPageView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI


struct StartPageView: View {
    var body: some View {
            VStack {
                VStack(spacing: 20) {
                    Text("Welcome ")
                        .bold()
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    NavigationLink(destination: ContentView()) {
                        Text("Get Started")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(30)
                            .padding()
                    }
                    
                }
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        
    }
}


#Preview {
    StartPageView()
}
