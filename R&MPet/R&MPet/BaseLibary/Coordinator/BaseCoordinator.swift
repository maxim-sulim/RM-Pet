//
//  BaseCoordinator.swift
//  R&MPet
//
//  Created by Максим Сулим on 18.02.2024.
//

import Foundation

class BaseCoordinator: NSObject, Coordinatable {
    var isStarted: Bool = false
    var childCoordinators: [Coordinatable] = []
    
    func start() {
        isStarted = true
    }
    
    func search(_ coordinator: Coordinatable.Type) -> Coordinatable? {
        if coordinator == type(of: self) {
            return self
        }
        
        for child in childCoordinators {
            if let found: Coordinatable = child.search(coordinator) {
                return found
            }
        }
        return nil
    }
    
    func addDependency(_ coordinator: Coordinatable) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinatable?) {
        guard childCoordinators.isEmpty == false,
              let coordinator = coordinator else { return }
        
        if let coordinator = coordinator as? BaseCoordinator, !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter({ $0 !== coordinator })
                .forEach({ coordinator.removeDependency($0) })
        }
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
    
}
