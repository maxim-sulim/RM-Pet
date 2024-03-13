//
//  PageProvider.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import Foundation
import RxSwift
import DITranquillity

protocol PageProvider: AnyObject {
    var state: Observable<PageProviderState> { get }
    var currentState: PageProviderState { get }
    func logout()
}

final class PageProviderImpl: PageProvider {
    lazy var state = $currentState.asObservable()
    @RxPublished private(set) var currentState = PageProviderState()
    let userStorageService: UserDefaultsService
    let keychainService: KeyChainService
    
    init(userStorage: UserDefaultsService, keychainService: KeyChainService) {
        self.userStorageService = userStorage
        self.keychainService = keychainService
    }
    
    func logout() {
        userStorageService.remove(key: .authUser)
        keychainService.removeStorage()
    }
}
