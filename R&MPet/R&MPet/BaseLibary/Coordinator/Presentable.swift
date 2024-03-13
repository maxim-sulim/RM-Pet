//
//  Presentable.swift
//  R&MPet
//
//  Created by Максим Сулим on 18.02.2024.
//

import UIKit

protocol Presentable {
    func toPresent() -> UIViewController?
}

extension UIViewController: Presentable {
    func toPresent() -> UIViewController? {
        return self
    }
}
