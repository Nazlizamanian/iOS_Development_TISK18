//
//  DayView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 11/02/25.

import SwiftUI

//Todoo: Each day be able to choose meals l
struct DayView: View {
    var selectedDate: Date
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            // Day Header
            Text(selectedDate, format: .dateTime.weekday(.wide).day().month(.abbreviated))
                .font(.largeTitle)
                .bold()
                .padding(.horizontal)
                .padding(.top)
            
            // Breakfast Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Image(systemName: "cup.and.saucer")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Text("Breakfast")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                Text("Add breakfast here")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .background(Color.mint)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            // Lunch Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Image(systemName: "fork.knife.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Text("Lunch")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                Text("Add lunch here")
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .background(Color.mint)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            // Dinner Section
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Image(systemName: "fork.knife.circle")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Text("Dinner")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                Text("Add dinner here") //Lägg till från listan ??
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .background(Color.mint)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            Spacer()
            
            //Snacks
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 15) {
                    Image(systemName: "takeoutbag.and.cup.and.straw")
                        .font(.system(size: 30))
                        .foregroundColor(.white)
                    
                    Text("Snacks")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                Text("Add snacks here") //Lägg till från listan ??
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
            .background(Color.mint)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            Spacer()
        }
        .padding()
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}
