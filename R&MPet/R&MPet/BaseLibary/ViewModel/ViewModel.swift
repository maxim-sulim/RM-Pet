//
//  ViewModel.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import RxSwift

protocol ViewModel {
    var isVisible: BehaviorSubject<Bool> { get }
}

extension ViewModel {
    func whenVisible<T: ObservableType>(state: T) -> Observable<T.Element> {
        Observable.combineLatest(state, isVisible)
            .filter { _, isVisible in isVisible }
            .map { state, _ in state }
    }
}
