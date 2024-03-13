//
//  AppDelegate.swift
//  R&MPet
//
//  Created by Максим Сулим on 18.02.2024.
//

import UIKit
import DITranquillity
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let container = DIContainer()
    
    var window: UIWindow?
    private var applicationCoordinator: AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        registerParts()
        createWindow()
        IQKeyboardManager.shared.enable = true
        return true
    }
}

extension AppDelegate {
    private func createWindow() {
        let window = UIWindow()
        let applicationCoordinator = AppCoordinator(window: window, container: container)
        self.applicationCoordinator = applicationCoordinator
        self.window = window
        
        window.makeKeyAndVisible()
        applicationCoordinator.start()
    }
    
    private func registerParts() {
        container.append(part: ModelPart.self)
        container.append(part: TabBarPart.self)
    }
}
