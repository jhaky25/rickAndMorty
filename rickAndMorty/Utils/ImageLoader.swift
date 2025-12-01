//
//  ImageLoader.swift
//  rickAndMorty
//
//  Created by Jaqueline Sanchez lopez on 01/12/25.
//

import UIKit
import Combine

final class ImageLoader {
    static let shared = ImageLoader()
    private var cache = NSCache<NSURL, UIImage>()
    
    func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Never> {
        guard let url = URL(string: urlString) else {
            return Just(nil).eraseToAnyPublisher()
        }
        
        if let cached = cache.object(forKey: url as NSURL) {
            return Just(cached).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { [weak self] data, _ -> UIImage? in
                let image = UIImage(data: data)
                if let image = image {
                    self?.cache.setObject(image, forKey: url as NSURL)
                }
                return image
            }
            .replaceError(with: nil)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
}
