//
//  AppCoordinator.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import UIKit
import DITranquillity
import RxSwift

final class AppCoordinator: BaseCoordinator {
    
    private let window: UIWindow
    private let container: DIContainer
    private let profileManager: ProfileManager
    
    init(window: UIWindow, container: DIContainer) {
        self.window = window
        self.container = container
        self.profileManager = container.resolve()
    }
    
    override func start() {
        configureObservable()
    }
    
    private func configureObservable(){
        let disposeBag = DisposeBag()
        profileManager
            .currentSession
            .asObservable()
            .map(\.authuser)
            .distinctUntilChanged()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] auth in
                self?.route(authUser: auth ?? false)
            }).disposed(by: disposeBag)
    }
    
    private func route(authUser: Bool) {
        authUser ? authorizedFlow() : unauthorizateFlow()
    }
    
    private func unauthorizateFlow() {
        let unauthorizedNavigationController = BaseNavigationController()
        let unauthorizedRouter = RouterImpl(rootController: unauthorizedNavigationController)
        let unauthorizateCoordinator = UnauthorizateCoordinator(router: unauthorizedRouter, container: container)
        addDependency(unauthorizateCoordinator)
        window.rootViewController = unauthorizedNavigationController
        
        unauthorizateCoordinator.onHomeShow = { [weak self, weak unauthorizateCoordinator] in
            self?.removeDependency(unauthorizateCoordinator)
            self?.authorizedFlow()
        }
        unauthorizateCoordinator.start()
    }
    
    private func authorizedFlow() {
        let tabBarProvider: TabBarProvider = container.resolve()
        let tabBarController = TabBarController(providerTabBar: tabBarProvider)
        let router = TabBarRouterImpl(tabBarController: tabBarController)
        let tabBarCoordinator = TabBarCoordinator(container: container, router: router)
        tabBarController.delegate = tabBarCoordinator
        addDependency(tabBarCoordinator)
        window.rootViewController = tabBarController
        
        tabBarCoordinator.onAuthShow = { [weak self, weak tabBarCoordinator] in
            self?.removeDependency(tabBarCoordinator)
            self?.unauthorizateFlow()
        }
        tabBarCoordinator.start()
    }
}
