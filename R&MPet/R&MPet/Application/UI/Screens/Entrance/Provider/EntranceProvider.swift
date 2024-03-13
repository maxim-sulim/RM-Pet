//
//  EntranceProvider.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation
import RxSwift

protocol EntranceProvider: AnyObject {
    var state: Observable<EntranceProviderState> { get }
    var currentState: EntranceProviderState { get }
    func toggleOpenPassord()
    func validText(status: ValidationTF, text: String?)
    func signIn()
    func checkValidUser() -> Bool
}

final class EntranceProviderImpl {
    lazy var state = $currentState.asObservable()
    @RxPublished private(set) var currentState = EntranceProviderState()
    var userStorage: UserDefaultsService
    var keychainService: KeyChainService
    
    init(userStorage: UserDefaultsService, keychain: KeyChainService) {
        self.userStorage = userStorage
        self.keychainService = keychain
    }
    
    private func validatorLogin(text: String) -> Bool {
        guard !text.isEmpty else { return false }
        for char in text {
            guard let asciiValue = char.asciiValue else { return false }
            if !(65...90).contains(asciiValue) && !(97...122).contains(asciiValue) {
                return false
            }
        }
        return !text.isEmpty
    }

    private func validatorPassword(text: String) -> Bool {
        guard !text.isEmpty else { return false }
        var isLatter = false
        var isNumber = false
        for char in text {
            if char.isLetter {
                isLatter = true
                guard let asciiValue = char.asciiValue else { return false }
                if !(65...90).contains(asciiValue) && !(97...122).contains(asciiValue) {
                    return false
                }
            } else if char.isNumber {
                isNumber = true
            }
        }
        return isNumber && isLatter
    }
}

extension EntranceProviderImpl: EntranceProvider {
    func toggleOpenPassord() {
        currentState.isSecurePassword.toggle()
    }
    
    func validText(status: ValidationTF, text: String?) {
        guard let text = text else { return }
        switch status {
        case .login:
            if validatorLogin(text: text) {
                currentState.validuserName = text
                currentState.loginState = .valid
            } else {
                if text.isEmpty {
                    currentState.loginState = .isEmpty
                } else {
                    currentState.loginState = .notEnglish
                }
            }
        case .password:
            if validatorPassword(text: text) {
                currentState.passwordState = .valid
            } else {
                currentState.passwordState = .errorValid
            }
        }
    }
    
    func signIn() {
        userStorage.set(object: true, key: .authUser)
        keychainService.set(object: currentState.validuserName, key: .nameUser)
    }
    
    func checkValidUser() -> Bool {
        currentState.loginState == .valid && currentState.passwordState == .valid
    }
}
