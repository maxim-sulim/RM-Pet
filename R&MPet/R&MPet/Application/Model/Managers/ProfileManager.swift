//
//  ProfileManager.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation
import RxSwift

struct ProfileManagerState {
    var authuser: Bool?
}

protocol ProfileManager: AnyObject {
    var state: ProfileManagerState { get }
    var currentSession: PublishedState<ProfileManagerState> { get }
    func clearUser()
}

final class ProfileManagerImpl {
    @RxPublished private(set) var state = ProfileManagerState()
    private(set) lazy var currentSession = $state
    private let userDefaultsService: UserDefaultsService
    private let disposeBag = DisposeBag()
    
    init(userDefaultsService: UserDefaultsService) {
        self.userDefaultsService = userDefaultsService
        $state.commit(changes: {
            $0.authuser = userDefaultsService.get(key: .authUser)
        })
    }
    
    private func clearUserStorage() {
        userDefaultsService.remove(key: .authUser)
    }
}

extension ProfileManagerImpl: ProfileManager {
    func clearUser() {
        clearUserStorage()
    }
}
