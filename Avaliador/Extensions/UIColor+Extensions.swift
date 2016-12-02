//
//  UIColor+Extensions.swift
//  Avaliador
//
//  Created by Daniel Bonates on 01/12/16.
//  Copyright © 2016 Daniel Bonates. All rights reserved.
//

import UIKit

extension UIColor {
    
    static var mainGreen: UIColor { return UIColor(hexString: "#083E28") }
    static var mainColor: UIColor { return UIColor(hexString: "#16a085") }
    static var actionColor: UIColor { return UIColor(hexString: "#1abc9c") }
    static var talkColor: UIColor { return UIColor(hexString: "#D84315") }
    static var workshopColor: UIColor { return UIColor(hexString: "#00838F") }
    static var openingColor: UIColor { return UIColor(hexString: "#AD1457") }
    static var breaktimeColor: UIColor { return UIColor(hexString: "#F9A825") }
    static var setupColor: UIColor { return UIColor(hexString: "#9E9D24") }

    convenience init(hex: Int32, alpha: CGFloat) {
        let r = CGFloat((hex >> 16) & 0xFF)
        let g = CGFloat((hex >> 8) & 0xFF)
        let b = CGFloat((hex) & 0xFF)
        
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }

    convenience init(hex: Int32) {
        self.init(hex: hex, alpha: 1.0)
    }

    convenience init(hexString: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        
        let index = hexString.characters.index(hexString.startIndex, offsetBy: hexString.hasPrefix("#") ? 1 : 0)
        let hexNormalized = hexString.substring(from: index)
        let scanner = Scanner(string: hexNormalized)
        var hexValue: CUnsignedLongLong = 0
        
        if scanner.scanHexInt64(&hexValue) {
            if hexNormalized.characters.count == 6 {
                red   = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                green = CGFloat((hexValue & 0x00FF00) >> 8)  / 255.0
                blue  = CGFloat(hexValue & 0x0000FF) / 255.0
            } else if hexNormalized.characters.count == 8 {
                red   = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                blue  = CGFloat((hexValue & 0x0000FF00) >> 8)  / 255.0
                alpha = CGFloat(hexValue & 0x000000FF)         / 255.0
            } else {
                print("Invalid hex string", terminator: "")
            }
        }
        
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }

}
