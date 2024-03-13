//
//  EntranceViewController.swift
//  R&MPet
//
//  Created by Максим Сулим on 19.02.2024.
//

import Foundation
import UIKit
import RxSwift
import SnapKit

final class EntranceViewController: UIViewController {
    
    private let viewModel: EntranceViewModel
    private lazy var disposeBag: DisposeBag = DisposeBag()
    
    init(viewModel: EntranceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private lazy var loginTextField: TextFieldView = {
        let textField = TextFieldView()
        textField.tag = 0
        textField.delegate = self
        return textField
    }()
    
    private lazy var passwordTextField: TextFieldView = {
        let textField = TextFieldView()
        textField.tag = 1
        textField.delegate = self
        return textField
    }()
    
    private lazy var stackTextView: UIStackView = {
        let yStack = UIStackView(arrangedSubviews: [loginTextField, passwordTextField])
        yStack.axis = .vertical
        yStack.distribution = .equalSpacing
        yStack.spacing = 10
        return yStack
    }()
    
    private lazy var signInButton: BaseButton = {
        let button = BaseButton()
        button.configure(style: .fill, title: "Sign In")
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return button
    }()
    
    private func setupView() {
        view.backgroundColor = .lightGray
        title = "Entrance View"
        view.addSubview(stackTextView)
        view.addSubview(signInButton)
        startListenViewModel()
        makeConstraint()
    }
    
    private func startListenViewModel() {
        viewModel.viewInputData.subscribe(onNext: { [weak self] viewInputData in
            self?.render(inputModel: viewInputData)
        }).disposed(by: disposeBag)
    }
    
    private func makeConstraint() {
        stackTextView.snp.makeConstraints { make in
            make.topMargin.equalToSuperview().offset(350)
            make.leftMargin.trailingMargin.equalToSuperview().inset(25)
        }
        signInButton.snp.makeConstraints { make in
            make.centerXWithinMargins.equalToSuperview()
            make.height.equalTo(40)
            make.bottomMargin.equalToSuperview().offset(-40)
        }
    }
    
    @objc private func signInTapped() {
        viewModel.events.onNext(.signInButtonTapped)
    }
    
    func render(inputModel: EntranceViewInputModel) {
        UIView.animate(withDuration: 0.4, animations: {
            self.passwordTextField.configure(inputData: inputModel.passwordTF)
            self.loginTextField.configure(inputData: inputModel.loginTF)
        })
    }
}

extension EntranceViewController: TextFieldViewDelegate {
    func validationTextField(tag: Int, text: String?) {
        if tag == 0 {
            viewModel.events.onNext(.didEndEditingTF(.login, text))
        } else if tag == 1 {
            viewModel.events.onNext(.didEndEditingTF(.password, text))
        }
    }
    
    func tappedopenPassword() {
        viewModel.events.onNext(.tappedEyePassword)
    }
}
