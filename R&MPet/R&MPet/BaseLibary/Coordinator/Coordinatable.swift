//
//  Coordinator.swift
//  R&MPet
//
//  Created by Максим Сулим on 18.02.2024.
//

import Foundation

protocol Coordinatable: AnyObject {
    var isStarted: Bool { get set }
    func start()
    func search(_ coordinator: Coordinatable.Type) -> Coordinatable?
}
