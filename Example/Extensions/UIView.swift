//
//  UIView.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

import UIKit

extension UIView {
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        clipsToBounds = true
        layer.cornerRadius = radius
        layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
    }
    
    func addShadow(shadowColor: CGColor = UIColor.black.withAlphaComponent(0.1).cgColor,
                   shadowOffset: CGSize = CGSize(width: 0.0, height: 5.0),
                   shadowOpacity: Float = 1.0,
                   shadowRadius: CGFloat = 25) {
        layer.masksToBounds = false
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
    func deleteShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 0.0)
        layer.shadowOpacity = 0
    }
}
