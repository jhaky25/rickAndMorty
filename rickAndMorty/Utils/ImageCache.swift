//
//  ImageCache.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit

final class ImageCache {
    
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func load(url: String, completion: @escaping (UIImage?) -> Void) {
        if let cached = cache.object(forKey: url as NSString) {
            completion(cached)
            return
        }
        
        guard let requestUrl = URL(string: url) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: requestUrl) { [weak self] data, _, _ in
            var image: UIImage? = nil
            if let data = data {
                image = UIImage(data: data)
                if let img = image {
                    self?.cache.setObject(img, forKey: url as NSString)
                }
            }
            DispatchQueue.main.async { completion(image) }
        }.resume()
    }
}
