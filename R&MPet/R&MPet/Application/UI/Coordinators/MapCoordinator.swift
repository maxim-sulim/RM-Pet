//
//  MapCoordinator.swift
//  R&MPet
//
//  Created by Максим Сулим on 21.02.2024.
//

import DITranquillity
import RxSwift


final class MapCoordinator: BaseCoordinator {
    
    let router: Routable
    
    private let container: DIContainer
    private let disposeBag = DisposeBag()
    
    init(router: Routable, container: DIContainer) {
        self.router = router
        self.container = container
        super.init()
        self.regiserParts()
    }
    
    private func regiserParts() {
        container.append(part: MapPart.self)
    }
    
    override func start() {
        showMapScene()
    }
    
    private func showMapScene() {
        let resolved: MapDependency = container.resolve()
        let viewModel = resolved.viewModel
        viewModel.output
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] output in
                guard let self else { return }
                switch output {
                default:
                    self.outPutEvent()
                }
            }).disposed(by: disposeBag)
        router.setRootModule(resolved.viewController, hideBar: false)
    }
    
    private func outPutEvent() {
        
    }
}
