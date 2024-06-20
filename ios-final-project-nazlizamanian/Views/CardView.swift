//
//  CardView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

struct CardView: View {
    @ObservedObject var model = MealsModel()
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    
    var body: some View {
        //strucuture for the cards
        ZStack{
            Rectangle()
                .frame(width: 360, height: 620)
                .cornerRadius(20)
                .foregroundColor(color.opacity(0.9))
                .shadow(radius: 4)
            HStack{
                ForEach(model.courses, id: \.id) { recipe in
                    ZStack(alignment: .leading) {
                        Image(systemName: "sun")
                        
                        Text(recipe.name)
                            .font(.headline)
                            .padding()
                    }
                }
                
            }
            .onAppear{
                model.fetch()
            }
        }
    }
    private func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150): // Swipe to left
            offset = CGSize(width: -500, height: 0)
            withAnimation {
                changeColor(width: offset.width)
            }
           

        case 150...500: // Swipe right
            offset = CGSize(width: 500, height: 0)
            changeColor(width: offset.width)
           

        default:
            offset = .zero
        }
    }

    private func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red

        case 130...500:
            color = .green

        default:
            color = .black
        }
    }
}

#Preview {
    CardView()
}
