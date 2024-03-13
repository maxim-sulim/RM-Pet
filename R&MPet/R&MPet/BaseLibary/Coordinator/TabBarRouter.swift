//
//  TabBarRouter.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit

protocol TabBarRouter: Presentable {
    func setViewControllers(viewControllers: [UIViewController], animated: Bool)
    
    func present(_ module: Presentable?)
    func present(_ module: Presentable?, animated: Bool)

    func dismissModule()
    func dismissModule(animated: Bool, completion: (() -> Void)?)
    
    func selectController(index: Int)
}
