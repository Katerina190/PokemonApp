//
//  DataProvider.swift
//  PokemonApplication
//
//  Created by Ekaterina Sedova on 12.05.23.
//

import UIKit

class DataProvider {
    
    var imageCache = NSCache<NSString, UIImage>()
    
    func loadImage(from urlString: String, completion: @escaping (UIImage?) -> Void) {
        let debugMode = true
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            if debugMode {
                        print("Image found in cache")
                    }
            completion(cachedImage)
        } else {
            guard let url = URL(string: urlString) else {
                        completion(nil)
                        return
                    }
             URLSession.shared.dataTask(with: url   ) { [weak self] data, response, error in
                
                guard error == nil,
                      data != nil,
                      let response = response as? HTTPURLResponse,
                      response.statusCode == 200,
                      let self = self else {
                    return
                }
                
                guard let image = UIImage(data: data!) else { return }
                self.imageCache.setObject(image, forKey: urlString as NSString)
                
                DispatchQueue.main.async {
                    completion(image)
                }
                 if debugMode {
                                 print("Image not found in cache")
                             }
            }.resume()
            print("Image not found in cache")
        }
    }
}
