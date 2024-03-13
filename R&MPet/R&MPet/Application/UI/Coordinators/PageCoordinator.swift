//
//  PageCoordinator.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import Foundation
import RxSwift
import DITranquillity
import UIKit


final class PageCoordinator: BaseCoordinator {
    
    let router: Routable
    
    private let container: DIContainer
    private let disposeBag = DisposeBag()
    public var onAuthShow: (() -> Void)?
    
    init(router: Routable, container: DIContainer) {
        self.router = router
        self.container = container
        super.init()
        self.regiserParts()
    }
    
    private func regiserParts() {
        container.append(part: PagePart.self)
    }
    
    override func start() {
        showPageScrene()
    }
    
    private func showPageScrene() {
        let resolved: PageDependency = container.resolve()
        let viewModel = resolved.viewModel
        viewModel.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] output in
                guard let self else { return }
                switch output {
                case.showAuth:
                    self.onAuthShow?()
                }
            }).disposed(by: disposeBag)
        router.setRootModule(resolved.viewController,hideBar: false)
    }
}
