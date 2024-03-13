//
//  ImageResourceAssets.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit

final class ImageResourceAssets {
    lazy var passwordTextFieldImage: UIImage = {
       UIImage(named: "PasswordPlaceholder")!
    }()
    lazy var loginTextFieldImage: UIImage = {
       UIImage(named: "LoginPlaceholder")!
    }()
    lazy var eyeOpen: UIImage = {
       UIImage(named: "EyeOpened")!
    }()
    lazy var eyeClosed: UIImage = {
       UIImage(named: "EyeClosed")!
    }()
    lazy var validError: UIImage = {
       UIImage(named: "ErrorValid")!
    }()
}
