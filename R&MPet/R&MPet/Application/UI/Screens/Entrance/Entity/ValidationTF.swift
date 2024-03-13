//
//  ValidationTF.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import Foundation

enum ValidationTF {
    case login
    case password
}

enum LoginValidation {
    case isEmpty
    case notEnglish
    case valid
}
enum PasswordValidation {
    case errorValid
    case valid
}
