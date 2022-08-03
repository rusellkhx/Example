//
//  ImageChache.swift
//  Example
//
//  Created by Rusell on 02.08.2022.
//

import UIKit

class ImageChache: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}
