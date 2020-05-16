//
//  UIImageView.swift
//  KittyCat
//
//  Created by Mac Developer on 16.05.2020.
//  Copyright © 2020 Viktoria. All rights reserved.
//

import UIKit

extension UIImageView {

    func loadImage(from url: String?) {
        if let sourceURL = url {
            if let cacheImage = imageCache.object(forKey: sourceURL as AnyObject) as? UIImage {
                self.image = cacheImage
                return
            }
            
            let queue = DispatchQueue.global(qos: .utility)
            if let urlFromString = URL(string: sourceURL) {
                queue.async { [weak self] in
                    if let data = try? Data(contentsOf: urlFromString), let image = UIImage(data: data) {
                        imageCache.setObject(image, forKey: sourceURL as AnyObject)
                        DispatchQueue.main.async {
                            self?.image = image
                        }
                    }
                }
            }
        }
    }
    
}
