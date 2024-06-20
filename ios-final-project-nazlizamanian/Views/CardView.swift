//
//  CardView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 19/06/24.
//

import SwiftUI

/*
 Sources used in this file:
 1.) Swipe card logic: https://www.youtube.com/watch?v=O2JXv9BnE70&t=311s
 */
struct URLImageView: View { //To get the images for each card
    let urlString: String
    @State private var imageData: Data?
    
    var body: some View {
        GeometryReader { geometry in
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .cornerRadius(20)
                   
            } else {
                Rectangle()
                    .cornerRadius(20)
                    .frame(width: geometry.size.width, height: geometry.size.height) // Placeholder size
                    .onAppear {
                        downloadImage()
                    }
            }
        }
    }
    
    private func downloadImage() {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error downloading image: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}

struct CardView: View {
    @ObservedObject var model = MealsModel()
    
    @State private var offset = CGSize.zero
    @State private var color: Color = .black
    @State private var currentIndex = 0
    
    var body: some View {
        //strucuture for the cards
    //Source: 1.) Swipe card logic
        ZStack {
            if currentIndex < model.courses.count {
                ForEach(Array(model.courses.enumerated()), id: \.element.id) { index, recipe in
                    if index >= currentIndex {
                        ZStack(alignment: .bottomLeading) {
                            URLImageView(urlString: recipe.image)
                                .frame(width: 375, height: 640)
                                .cornerRadius(20)
                               
                                .clipped()
                                .aspectRatio(contentMode: .fill)
                                .overlay(
                                    VStack {
                                        Spacer()
                                        Text(recipe.name)
                                            .font(.title)
                                            .fontWeight(.black) //bold
                                            .foregroundColor(.white)
                                            .padding(.bottom,50)
                                    },
                                    alignment: .center
                                )

                          
                                
                        }
                        .offset(x: offset.width, y: offset.height * 0.4)
                        .rotationEffect(.degrees(Double(offset.width / 40)))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    offset = gesture.translation
                                }
                                .onEnded { _ in
                                    withAnimation {
                                        swipeCard(width: offset.width)
                                    }
                                }
                        )
                        .zIndex(Double(model.courses.count - index))
                    }
                }
            }
        }
        .padding()
        .onAppear{
            model.fetch()
        }
        
        
        HStack{ //Buttons
            Button(action: { //Go back button
                withAnimation{
                    //Go back somehow?
                }
                
            }) {
                Image(systemName: "arrow.uturn.left")
                    .resizable()
                    .bold() //makes the arrow thicker.
                    .frame(width: 35, height: 35)
                    .foregroundColor(Color(red: 0.95, green: 0.73, blue: 0.15))
                    .padding(14)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.yellow, lineWidth: 2)
            )
            Spacer()
            Button(action:{ //X button swipe left
                withAnimation{
                    swipeCard(width: -200)
                }
               
            }){
                Image(systemName:"xmark")
                    .resizable()
                    .frame(width:35, height:35)
                    .foregroundColor(.red)
                    .padding(14)
                    .bold()
            }
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.red, lineWidth: 2)
            )
            Spacer()

            Button(action: { //swipe right
                withAnimation{
                    swipeCard(width: 200)
                }
            }){
                Image(systemName:"heart.fill")
                    .resizable()
                    .frame(width:35, height:35)
                    .foregroundColor(Color(red: 0.15, green: 0.87, blue: 0.57))
                    .padding(14)
            }
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.green, lineWidth: 2)
            )
        }
        .padding(.horizontal, 40)
    }
    private func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150): // Swipe to left
            offset = CGSize(width: -500, height: 0)
            withAnimation {
                changeColor(width: offset.width)
            }
            moveToNextCard()
           

        case 150...500: // Swipe right
            offset = CGSize(width: 500, height: 0)
            changeColor(width: offset.width)
            moveToNextCard()
           

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
    private func moveToNextCard() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if currentIndex < model.courses.count {
                currentIndex += 1
                offset = .zero
                color = .black
            }
        }
    }
}

#Preview {
    CardView()
}
