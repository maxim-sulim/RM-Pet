//
//  MapPart.swift
//  R&MPet
//
//  Created by Максим Сулим on 21.02.2024.
//

import DITranquillity

final class MapPart: DIPart {
    static func load(container: DIContainer) {
        container.register(MapProviderImpl.init).as(MapProvider.self).lifetime(.objectGraph)
        container.register(MapViewModelImpl.init(provider:)).as(MapViewModel.self).lifetime(.objectGraph)
        container.register(MapViewController.init(viewModel:)).lifetime(.objectGraph)
        container.register(MapDependency.init(viewController: viewModel:)).lifetime(.prototype)
    }
}

struct MapDependency {
    var viewController: MapViewController
    var viewModel: MapViewModel
}
