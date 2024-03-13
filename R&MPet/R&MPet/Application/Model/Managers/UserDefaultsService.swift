//
//  UserDefaultsService.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation

enum UserDefaultsKeys: String {
    case authUser
}

protocol UserDefaultsService: AnyObject {
    func set(object: Any, key: UserDefaultsKeys)
    func get<T>(key: UserDefaultsKeys) -> T?
    func remove(key: UserDefaultsKeys)
}

final class UserDefaultsServiceImpl: UserDefaultsService {
    
    private lazy var storage = UserDefaults.standard
    
    init() {}
    
    func set(object: Any, key: UserDefaultsKeys) {
        storage.setValue(object, forKey: key.rawValue)
    }
    
    func get<T>(key: UserDefaultsKeys) -> T? {
        storage.object(forKey: key.rawValue) as? T
    }
    func remove(key: UserDefaultsKeys) {
        storage.removeObject(forKey: key.rawValue)
    }
}
