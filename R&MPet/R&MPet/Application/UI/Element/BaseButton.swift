//
//  BaseButton.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit

class BaseButton: UIButton {
    enum Style {
        case fill
        case unfill
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func getButtonConfigure(style: Style, title: String) -> UIButton.Configuration {
        let colorAsset = ColorResourceAssets()
        var configure = UIButton.Configuration.filled()
        switch style {
        case .fill:
            configure.background.backgroundColor = colorAsset.buttonBackground
        case .unfill:
            configure.background.backgroundColor = UIColor.clear
        }
        configure.baseForegroundColor = UIColor.white
        configure.buttonSize = .large
        configure.cornerStyle = .capsule
        configure.titleAlignment = .center
        configure.title = title
        return configure
    }
    
    //public
    public func configure(style: Style, title: String) {
        self.configurationUpdateHandler  = { [weak self] button in
            switch button.state {
            case .normal:
                button.configuration = self?.getButtonConfigure(style: style, title: title)
            default:
                break
            }
        }
    }
}
