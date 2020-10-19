//
//  ImageView+Extension.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func cacheImage(urlString: String) {
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                if let response = data, let imageToCache = UIImage(data: response) {
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                    self.image = imageToCache
                }
            }
        }.resume()
    }
}
