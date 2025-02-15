//
//  URLImageView.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 15/02/25.
//

import SwiftUI

struct URLImage: View { //responsible for showing the actually image
    @StateObject private var viewModel = URLImageLoadingViewModel()
    let urlString: String

    var body: some View {
        GeometryReader { geometry in
            if let imageData = viewModel.imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
            } else {
                Rectangle()
                    .foregroundColor(.gray.opacity(0.3))
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .onAppear { viewModel.fetchImage(from: urlString) }
            }
        }
    }
}
