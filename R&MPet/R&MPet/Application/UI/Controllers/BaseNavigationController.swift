//
//  BaseNavigationController.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import UIKit

final class BaseNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .brown
    }
 
    convenience init(tabItemImage: UIImage?) {
        self.init()
        self.tabBarItem = UITabBarItem(title: "",
                                       image: tabItemImage,
                                       selectedImage: nil)
    }
}
