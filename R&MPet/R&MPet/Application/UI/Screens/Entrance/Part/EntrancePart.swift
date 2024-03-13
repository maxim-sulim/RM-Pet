//
//  EntrancePart.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import DITranquillity

final class EntrancePart: DIPart {
    static func load(container: DIContainer) {
        container.register(EntranceProviderImpl.init).as(EntranceProvider.self).lifetime(.objectGraph)
        container.register(EntranceViewModelImpl.init(provider:)).as(EntranceViewModel.self).lifetime(.objectGraph)
        container.register(EntranceViewController.init(viewModel:)).lifetime(.objectGraph)
        container.register(EntranceDependency.init(viewController: viewModel:)).lifetime(.prototype)
    }
}

struct EntranceDependency {
    let viewController: EntranceViewController
    let viewModel: EntranceViewModel
}
