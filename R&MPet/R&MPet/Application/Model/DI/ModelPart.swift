//
//  ModelPart.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import DITranquillity

final class ModelPart: DIPart {
    static func load(container: DIContainer) {
        container.register(ProfileManagerImpl.init).as(ProfileManager.self).lifetime(.perRun(.strong))
        container.register(UserDefaultsServiceImpl.init).as(UserDefaultsService.self).lifetime(.perRun(.weak))
        container.register(KeyChainServiceImpl.init).as(KeyChainService.self).lifetime(.perRun(.weak))
    }
}

