//
//  MapProvider.swift
//  R&MPet
//
//  Created by Максим Сулим on 21.02.2024.
//

import Foundation
import RxSwift


protocol MapProvider: AnyObject {
    var state: Observable<MapProviderState> { get }
    var currentState: MapProviderState { get }
}

final class MapProviderImpl: MapProvider {
    lazy var state = $currentState.asObservable()
    @RxPublished private(set) var currentState = MapProviderState()
    
    init() {}
}
