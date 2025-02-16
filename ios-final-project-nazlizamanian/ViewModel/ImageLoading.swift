//
//  ImageLoading.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 15/02/25.
//

import Foundation

//responsible for actucally fetching the image
class URLImageLoadingViewModel: ObservableObject {
    
    @Published var imageData: Data?
    
    func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}


