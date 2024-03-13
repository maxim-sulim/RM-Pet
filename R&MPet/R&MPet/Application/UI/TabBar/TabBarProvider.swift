//
//  TabBarProvider.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import Foundation
import RxSwift

protocol TabBarProvider {
    var state: Observable<TabBarProviderState> { get }
    var currentState: TabBarProviderState { get }
}

final class TabBarProviderImpl: TabBarProvider {
    
    lazy var state = $currentState.asObservable()
    @RxPublished var currentState = TabBarProviderState()
    
    init() {}
}
