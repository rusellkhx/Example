//
//  UIColor.swift
//  Example
//
//  Created by Rusell on 31.07.2022.
//

import UIKit

extension UIColor {
    @nonobjc class var rbMainAccent: UIColor {
        UIColor(hex: "#6C30F7")
    }
    
    @nonobjc class var rbSuperAccent: UIColor {
        UIColor(hex: "#7438FF")
    }
    
    @nonobjc class var rbSecondaryAccent: UIColor {
        UIColor(hex: "#00ECD5")
    }
    
    @nonobjc class var rbMainTexts: UIColor {
        UIColor(hex: "#6E7994")
    }
    
    @nonobjc class var rbWhiteText: UIColor {
        UIColor(hex: "#FEFEFE")
    }
    
    @nonobjc class var rbDarkText: UIColor {
        UIColor(hex: "#0E1F4D")
    }
    
    @nonobjc class var rbDarkTextAlpha04: UIColor {
        UIColor(hex: "#0E1F4D", alpha: 0.4)
    }
    
    @nonobjc class var rbDarkBorderAlpha04: UIColor {
        UIColor(hex: "#233848", alpha: 0.4)
    }
    
    @nonobjc class var rbBitterSweet: UIColor {
        UIColor(hex: "#FF6D6D")
    }
    
    @nonobjc class var rbShadow: UIColor {
        UIColor(hex: "#233848")
    }
    
    convenience init(hex: String, alpha: CGFloat = 1) {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}

