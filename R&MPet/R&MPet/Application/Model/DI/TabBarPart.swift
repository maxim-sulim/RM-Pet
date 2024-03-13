//
//  TabBarPart.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import DITranquillity

final class TabBarPart: DIPart {
    static func load(container: DIContainer) {
        container.register(TabBarProviderImpl.init).as(TabBarProvider.self).lifetime(.perRun(.weak))
    }
}
