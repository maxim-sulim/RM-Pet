//
//  MapViewModel.swift
//  R&MPet
//
//  Created by Максим Сулим on 21.02.2024.
//

import Foundation
import RxSwift

struct MapViewInputModel {
    
}

protocol MapViewModel: ViewModel {
    var viewInputData: Observable<MapViewInputModel> { get }
    var events: PublishSubject<MapViewEvents> { get }
    var output: PublishSubject<MapViewOutputEvents> { get }
}

final class MapViewModelImpl: MapViewModel {
    
    private var provider: MapProvider
    private let disposebag = DisposeBag()
    let isVisible = BehaviorSubject(value: false)
    var viewInputData: Observable<MapViewInputModel>
    private(set) var events = PublishSubject<MapViewEvents>()
    private(set) var output = PublishSubject<MapViewOutputEvents>()
    
    
    init(provider: MapProvider) {
        self.provider = provider
        viewInputData = provider.state.observe(on: MainScheduler.instance).map({$0.viewInputData()})
        self.events
            .observe(on: SerialDispatchQueueScheduler.init(qos: .userInteractive))
            .subscribe(onNext: { [weak self] event in
                self?.onEvent(event: event)
            }).disposed(by: disposebag)
    }
    
    private func onEvent(event: MapViewEvents) {
        
    }
}

extension MapProviderState {
    func viewInputData() -> MapViewInputModel {
        MapViewInputModel()
    }
}
