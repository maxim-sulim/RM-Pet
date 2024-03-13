//
//  ColorResourcesAssets.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit


final class ColorResourceAssets {
    lazy var greenValid: UIColor = {
        UIColor().hexStringToUIColor(hex: "#239158")
    }()
    lazy var redValid: UIColor = {
        UIColor().hexStringToUIColor(hex: "#a83250")
    }()
    lazy var buttonBackground: UIColor = {
        UIColor().hexStringToUIColor(hex: "#65758a")
    }()
    lazy var buttonForeground: UIColor = {
        UIColor().hexStringToUIColor(hex: "#1f4c5c")
    }()
}
