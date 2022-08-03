//
//  UIImage.swift
//  Example
//
//  Created by Rusell on 01.08.2022.
//

import UIKit

extension UIImageView {
    func setRounded() {
        let radius = self.frame.width / 2
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func url(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let self = self,
                  let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            
            func setImage(image: UIImage?) {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
            
            let urlToString = url.absoluteString as NSString
            
            if let cachedImage = ImageChache.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageChache.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            } else {
                setImage(image: nil)
            }
        }
    }
}
