//
//  UIColorExtension.swift
//  nakitaevPW2
//
//  Created by Никита Китаев on 07.02.2024.
//

import UIKit

// MARK: UIColor extension.
extension UIColor {
    enum Constants {
        static let hexPrefix: String = "#"
        
        static let maxColorValue: CGFloat = 255
        
        static let redMask: UInt64 = 0xFF0000
        static let greenMask: UInt64 = 0x00FF00
        static let blueMask: UInt64 = 0x0000FF
        
        static let redShift: UInt64 = 16
        static let greenShift: UInt64 = 8
    }

    convenience init(_ hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: Constants.hexPrefix, with: "")
        var rgb: UInt64 = 0
        
        let scanner = Scanner(string: hexSanitized)
        
        if !scanner.scanHexInt64(&rgb) {
            self.init(red: 0, green: 0, blue: 0, alpha: 1.0)
        }
        
        let red = CGFloat((rgb & Constants.redMask) >> Constants.redShift) / Constants.maxColorValue
        let green = CGFloat((rgb & Constants.greenMask) >> Constants.greenShift) / Constants.maxColorValue
        let blue = CGFloat(rgb & Constants.blueMask) / Constants.maxColorValue
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    // MARK: Converts color to HEX string.
    func hexStringFromColor() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0

        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        
        return hexString
     }
    
    // MARK: Converts color to RGB array.
    func RGBFromColor() -> [Float] {
        let backGroundRGB = self.cgColor.components
        
        let red = Float((backGroundRGB?[0])!)
        let green = Float((backGroundRGB?[1])!)
        let blue = Float((backGroundRGB?[2])!)
        
        return [red, green, blue]
    }
    
    // MARK: Returns a random color.
    static func getRandom() -> UIColor {
        let randomRed = CGFloat(drand48())
        let randomGreen = CGFloat(drand48())
        let randomBlue = CGFloat(drand48())
            
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}

