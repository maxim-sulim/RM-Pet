//
//  PagePart.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import DITranquillity

final class PagePart: DIPart {
    static func load(container: DIContainer) {
        container.register(PageProviderImpl.init).as(PageProvider.self).lifetime(.objectGraph)
        container.register(PageViewModelImpl.init(provider:)).as(PageViewModel.self).lifetime(.objectGraph)
        container.register(PageViewController.init(viewModel:)).lifetime(.objectGraph)
        container.register(PageDependency.init(viewController: viewModel:)).lifetime(.prototype)
    }
}

struct PageDependency {
    let viewController: PageViewController
    let viewModel: PageViewModel
}
