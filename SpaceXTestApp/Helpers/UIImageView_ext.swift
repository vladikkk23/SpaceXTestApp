//
//  UIImageView_ext.swift
//  SpaceXTestApp
//
//  Created by vladikkk on 10/12/2020.
//

import UIKit

// Cache images
let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadImage(withUrl url: URL) {
        if let cachedImage = imageCache.object(forKey: NSString(string: url.absoluteString)) {
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async { [weak self] in
            if let imageData = try? Data(contentsOf: url) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        imageCache.setObject(image, forKey: NSString(string: url.absoluteString))
                        
                        self?.image = image
                    }
                }
            }
        }
    }
}
