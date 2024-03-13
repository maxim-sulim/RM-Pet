//
//  TabBarCoordinator.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit
import DITranquillity
import RxSwift

final class TabBarCoordinator: BaseCoordinator {
    
    private typealias Flow = (Coordinatable, Presentable)
    
    private let container: DIContainer
    private let router: TabBarRouter
    private let disposeBag = DisposeBag()
    public var onAuthShow: (() -> Void)?
    
    init(container: DIContainer, router: TabBarRouter) {
        self.container = container
        self.router = router
        super.init()
    }
    
    override func start() {
        let flows = [mapFlow(),pageFlow()]
        let controllers = flows.map({$0.1})
        let coordinators = flows.map({$0.0})
        router.setViewControllers(viewControllers: controllers, animated: false)
        coordinators.forEach({
            addDependency($0)
            $0.start()
        })
    }
    
    private func pageFlow() -> (BaseCoordinator, BaseNavigationController) {
        let itemImage = UIImage(systemName: "person")
        let navigationController = BaseNavigationController(tabItemImage: itemImage)
        let router = RouterImpl(rootController: navigationController)
        let coordinator = PageCoordinator(router: router, container: container)
        coordinator.onAuthShow = self.onAuthShow
        return (coordinator, navigationController)
    }
    
    private func mapFlow() -> (BaseCoordinator, BaseNavigationController) {
        let itemImage = UIImage(systemName: "map")
        let navigationController = BaseNavigationController(tabItemImage: itemImage)
        let router = RouterImpl(rootController: navigationController)
        let coordinator = MapCoordinator(router: router, container: container)
        return (coordinator, navigationController)
    }
}

extension TabBarCoordinator: UITabBarControllerDelegate {

    
}
