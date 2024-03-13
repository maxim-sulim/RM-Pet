//
//  ViewController + ext.swift
//  R&MPet
//
//  Created by Максим Сулим on 18.02.2024.
//

import UIKit

extension UIViewController {
    var topPresentedViewController: UIViewController? {
        guard var topPresentedController = presentedViewController else { return nil }
        
        while let presentedController = topPresentedController.presentedViewController {
            topPresentedController = presentedController
        }
        
        return topPresentedController
    }
}
