//
//  PageViewModel.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit
import RxSwift

struct PageViewInputData {
    
}

protocol PageViewModel: ViewModel {
    var viewInputData: Observable<PageViewInputData> { get }
    var events: PublishSubject<PageViewEvents> { get }
    var output: PublishSubject<PageViewOutputEvents> { get }
}

final class PageViewModelImpl: PageViewModel {
    
    let viewInputData: Observable<PageViewInputData>
    let isVisible = BehaviorSubject(value: false)
    private(set) var events = PublishSubject<PageViewEvents>()
    private(set) var output = PublishSubject<PageViewOutputEvents>()
    
    private var provider: PageProvider
    private let disposeBag = DisposeBag()
    
    init(provider: PageProvider) {
        self.provider = provider
        viewInputData = provider.state.observe(on: MainScheduler.instance).map({ $0.viewInputData() })
        
        self.events
            .observe(on: SerialDispatchQueueScheduler.init(qos: .userInteractive))
            .subscribe(onNext: { [weak self] event in
                self?.onEvent(event: event)
            })
            .disposed(by: disposeBag)
    }
    
    private func onEvent(event: PageViewEvents) {
        switch event {
        case .tappedLogout:
            provider.logout()
            output.onNext(.showAuth)
        }
    }
}

extension PageProviderState {
    func viewInputData() -> PageViewInputData {
        PageViewInputData()
    }
}
