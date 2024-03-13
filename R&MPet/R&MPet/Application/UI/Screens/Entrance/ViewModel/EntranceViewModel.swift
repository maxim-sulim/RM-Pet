//
//  EntranceViewModel.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation
import DITranquillity
import UIKit
import RxSwift

struct EntranceViewInputModel {
    let loginTF: TextFieldModel
    let passwordTF: TextFieldModel
}

protocol EntranceViewModel: ViewModel {
    var viewInputData: Observable<EntranceViewInputModel> { get }
    var events: PublishSubject<EntranceViewEvent> { get }
    var output: PublishSubject<EntranceOutputEvent> { get }
}

final class EntranceViewModelImpl: EntranceViewModel {
    private var provider: EntranceProvider
    private let disposeBag = DisposeBag()
    
    let viewInputData: Observable<EntranceViewInputModel>
    let isVisible = BehaviorSubject(value: false)
    private(set) var events = PublishSubject<EntranceViewEvent>()
    private(set) var output = PublishSubject<EntranceOutputEvent>()
    
    init(provider: EntranceProvider) {
        self.provider = provider
        viewInputData = provider.state.observe(on: MainScheduler.instance).map({$0.viewInputData()})
        
        self.events
            .observe(on: SerialDispatchQueueScheduler.init(qos: .userInitiated))
            .subscribe(onNext: {[weak self] event in
                self?.onEvent(event)
            })
            .disposed(by: disposeBag)
    }
    
    private func onEvent(_ event: EntranceViewEvent) {
        switch event {
        case .didEndEditingTF(let validationTF, let string):
            provider.validText(status: validationTF, text: string)
        case .tappedEyePassword:
            provider.toggleOpenPassord()
        case .signInButtonTapped:
            guard provider.checkValidUser() else { return }
            provider.signIn()
            output.onNext(.showTabBar)
        }
    }
}

extension EntranceProviderState {
    func viewInputData() -> EntranceViewInputModel {
        let imageAssets = ImageResourceAssets()
        let colorAssets = ColorResourceAssets()
        var boarderColorPassword = UIColor.white
        var labelErrorPassword = ""
        var isErrorPassword = false
        let passwordEye = isSecurePassword ? imageAssets.eyeClosed : imageAssets.eyeOpen
        
        switch passwordState {
        case .none:
            break
        case .errorValid:
            boarderColorPassword = colorAssets.redValid
            isErrorPassword = true
            labelErrorPassword = "error: not valid password"
        case .valid:
            boarderColorPassword = colorAssets.greenValid
        }
        
        let passwordTF = TextFieldModel(boarderColor: boarderColorPassword,
                                        isError: isErrorPassword,
                                        placeHolder: "Password",
                                        errorLabel: labelErrorPassword,
                                        image: imageAssets.passwordTextFieldImage,
                                        rightImage: passwordEye,
                                        isSecureText: isSecurePassword)
        
        var isErrorLogin = false
        var labelErrorLogin = ""
        var boarderColorLogin = UIColor.white
        
        switch loginState {
        case .none:
            break
        case .isEmpty:
            labelErrorLogin = "your login is empty"
            boarderColorLogin = colorAssets.redValid
            isErrorLogin = true
        case .notEnglish:
            labelErrorLogin = "your login not english"
            boarderColorLogin = colorAssets.redValid
            isErrorLogin = true
        case .valid:
            boarderColorLogin = colorAssets.greenValid
        }
        
        let loginTF = TextFieldModel(boarderColor: boarderColorLogin,
                                     isError: isErrorLogin,
                                     placeHolder: "Login",
                                     errorLabel: labelErrorLogin,
                                     image: imageAssets.loginTextFieldImage,
                                     rightImage: nil,
                                     isSecureText: false)
        
        return EntranceViewInputModel(loginTF: loginTF, passwordTF: passwordTF)
    }
}
