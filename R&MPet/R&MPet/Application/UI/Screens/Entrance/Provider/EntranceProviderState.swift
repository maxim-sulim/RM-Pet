//
//  EntranceProviderState.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation

struct EntranceProviderState {
    var isSecurePassword: Bool = true
    var loginState: LoginValidation?
    var passwordState: PasswordValidation?
    var validuserName: String = ""
}
