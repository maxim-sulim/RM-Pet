//
//  TabBarController.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit

class TabBarController: UITabBarController {
    
    private let providerTabBar: TabBarProvider
    
    init(providerTabBar: TabBarProvider) {
        self.providerTabBar = providerTabBar
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
        setupTabBar()
    }
    
    private func setupTabBar() {
        tabBar.tintColor = ColorResourceAssets().buttonForeground
        tabBar.backgroundColor = .white
        tabBar.clipsToBounds = true
        tabBar.layer.cornerRadius = 16
    }
}
