//
//  UIFont + ext.swift
//  R&MPet
//
//  Created by Максим Сулим on 21.02.2024.
//

import UIKit

extension UIFont {
    enum Style {
        case base
        
        var font: UIFont {
            switch self {
            case .base: return UIFont.montserratFont(ofSize: 23, font: .bold)
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .base: return .white
            }
        }
    }
    
    enum Font: String {
        case regular = "Montserrat-Regular"
        case semibold = "Montserrat-Medium"
        case bold = "Montserrat-Bold"
        case light = "Montserrat-Light"
        case thin = "Montserrat-Thin"
    }
    
    static func montserratFont(ofSize fontSize: CGFloat, font: Font) -> UIFont {
        return self.init(name: font.rawValue, size: fontSize)!
    }
}
