//
//  EntranceViewEvents.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation
import RxSwift

enum EntranceOutputEvent {
    case showTabBar
}

enum EntranceViewEvent {
    case didEndEditingTF(ValidationTF, String?)
    case tappedEyePassword
    case signInButtonTapped
}
