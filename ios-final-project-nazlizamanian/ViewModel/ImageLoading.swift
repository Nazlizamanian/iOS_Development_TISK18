//
//  ImageLoading.swift
//  ios-final-project-nazlizamanian
//
//  Created by Nazli  on 15/02/25.
//
import Foundation
import SwiftUI
import Observation


//Resonpsible for showing image fetching
@Observable
class URLImageLoading {
    var imageData: Data?
    
    func fetchImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            DispatchQueue.main.async {
                self?.imageData = data
            }
        }.resume()
    }
}



