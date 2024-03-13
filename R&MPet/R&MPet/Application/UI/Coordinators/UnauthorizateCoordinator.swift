//
//  UnauthorizateCoordinator.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation
import RxSwift
import DITranquillity
import UIKit

final class UnauthorizateCoordinator: BaseCoordinator {
    var router: Routable
    
    private let container: DIContainer
    private let disposeBag = DisposeBag()
    private let profileManager: ProfileManager
    public var onHomeShow: (() -> Void)?
    
    init(router: Routable, container: DIContainer) {
        self.router = router
        self.container = container
        self.profileManager = container.resolve()
        super.init()
        regiserPart()
    }
    
    override func start() {
        setRoot()
    }
    
    private func regiserPart() {
        container.append(part: EntrancePart.self)
    }
    
    private func setRoot() {
        let resolved: EntranceDependency = container.resolve()
        let viewModel = resolved.viewModel
        viewModel.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] output in
                guard let self else { return }
                switch output {
                case .showTabBar:
                    self.onHomeShow?()
                }
            }).disposed(by: disposeBag)
        router.setRootModule(resolved.viewController)
    }
}

