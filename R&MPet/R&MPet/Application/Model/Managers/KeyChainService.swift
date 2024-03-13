//
//  KeyChainService.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import Foundation
import KeychainSwift

enum KeyChainKey: String {
    case nameUser
}

protocol KeyChainService: AnyObject {
    func set(object: Encodable, key: KeyChainKey)
    func get<T>(key: KeyChainKey) -> T?
    func removeStorage()
}

final class KeyChainServiceImpl: KeyChainService {
    let keychain = KeychainSwift()
    let encoder = JSONEncoder()
    
    func set(object: Encodable, key: KeyChainKey) {
        do {
            let data = try encoder.encode(object)
            keychain.set(data, forKey: key.rawValue)
        } catch {
            return
        }
    }
    
    func get<T>(key: KeyChainKey) -> T? {
        guard let dataFromStorage = keychain.getData(key.rawValue) else { return nil }
        return dataFromStorage as? T
    }
    
    func removeStorage() {
        keychain.clear()
    }
}
