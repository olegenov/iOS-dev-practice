//
//  UIColorExtension.swift
//  GalleryApp
//
//  Created by Никита Китаев on 19.03.2024.
//

import UIKit

// MARK: UIColor extension.
extension UIColor {
    public enum AppColors {
        static let textColor: UIColor = UIColor("#000000")
        static let backgroundColor: UIColor = UIColor("#FFFFFF")
        static let outlineColor: UIColor = UIColor("#606060")
        static let accentColor: UIColor = UIColor("#584CE2")
        static let white: UIColor = UIColor("FFFFFF")
        static let lightAccentColor: UIColor = UIColor("#6456FF")
        static let red: UIColor = UIColor("#FEB5B5")
        static let darkRed: UIColor = UIColor("#A54242")
        static let cardBackgroundColor: UIColor = UIColor("#EBEBEB")
    }
    
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
}
