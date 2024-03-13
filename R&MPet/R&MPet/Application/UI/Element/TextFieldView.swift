//
//  TextFieldView.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit

struct TextFieldModel {
    let boarderColor: UIColor
    let isError: Bool
    let placeHolder: String
    let errorLabel: String
    let image: UIImage
    let rightImage: UIImage?
    let isSecureText: Bool
}

protocol TextFieldViewDelegate: AnyObject {
    func validationTextField(tag: Int, text: String?)
    func tappedopenPassword()
}

final class TextFieldView: UIView {

    weak var delegate: TextFieldViewDelegate?
    private lazy var heightError: NSLayoutConstraint = {
        let constraint = errorContainer.heightAnchor.constraint(equalToConstant: 0)
        return constraint
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.backgroundColor = .clear
        textField.tintColor = .black
        textField.textColor = .white
        return textField
    }()
    
    private lazy var imageTextField: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var imageRightPasswordButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(tappedPassword), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var textFieldContainer: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [imageTextField, textField, imageRightPasswordButton])
        stack.axis = .horizontal
        stack.spacing = 6
        stack.distribution = .fillProportionally
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var boarderView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        return view
    }()
    
    private lazy var errorImage: UIImageView = {
        let view = UIImageView()
        let image = ImageResourceAssets().validError
        view.image = image
        return view
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.red
        let font = UIFont.systemFont(ofSize: 12)
        label.font = font
        return label
    }()
    
    private lazy var errorContainer: UIStackView = {
        let xStack = UIStackView(arrangedSubviews: [errorImage, errorLabel])
        xStack.axis = .horizontal
        xStack.isHidden = true
        xStack.spacing = 8
        xStack.distribution = .fillProportionally
        xStack.translatesAutoresizingMaskIntoConstraints = false
        return xStack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(boarderView)
        boarderView.addSubview(textFieldContainer)
        addSubview(errorContainer)
        errorContainer.addConstraint(heightError)
        makeConstraint()
    }
    
    private func makeConstraint() {
        NSLayoutConstraint.activate([
            boarderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            boarderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            boarderView.topAnchor.constraint(equalTo: topAnchor),
            boarderView.heightAnchor.constraint(equalToConstant: 46),
            
            textFieldContainer.topAnchor.constraint(equalTo: boarderView.topAnchor),
            textFieldContainer.bottomAnchor.constraint(equalTo: boarderView.bottomAnchor),
            textFieldContainer.leadingAnchor.constraint(equalTo: boarderView.leadingAnchor, constant: 20),
            textFieldContainer.trailingAnchor.constraint(equalTo: boarderView.trailingAnchor, constant: -20),
            textFieldContainer.centerYAnchor.constraint(equalTo: boarderView.centerYAnchor),
            
            errorContainer.leadingAnchor.constraint(equalTo: leadingAnchor),
            errorContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            errorContainer.topAnchor.constraint(equalTo: boarderView.bottomAnchor,constant: 10),
            
            imageTextField.heightAnchor.constraint(equalToConstant: 22),
            imageTextField.widthAnchor.constraint(equalToConstant: 22),
            
            imageRightPasswordButton.heightAnchor.constraint(equalToConstant: 25),
            imageRightPasswordButton.widthAnchor.constraint(equalToConstant: 25),
            
            errorImage.heightAnchor.constraint(equalToConstant: 18),
            errorImage.widthAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    @objc private func tappedPassword() {
        delegate?.tappedopenPassword()
    }
    
    private func animateError(isError: Bool) {
        UIView.animate(withDuration: 0.4, animations: {
           
            self.layoutSubviews()
            self.updateConstraints()
        }, completion: { [weak self] _ in
            if isError {
                self?.heightError.constant = 22
                self?.errorContainer.isHidden = false
            } else {
                self?.heightError.constant = 0
                self?.errorContainer.isHidden = true
            }
        })
    }
    
    //public
    func configure(inputData: TextFieldModel) {
        errorLabel.text = inputData.errorLabel
        boarderView.layer.borderColor = inputData.boarderColor.cgColor
        let placeHolder = NSAttributedString(string: inputData.placeHolder,
                                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        textField.attributedPlaceholder = placeHolder
        imageTextField.image = inputData.image
        imageRightPasswordButton.setImage(inputData.rightImage, for: .normal)
        textField.isSecureTextEntry = inputData.isSecureText
        errorLabel.text = inputData.errorLabel
        
        animateError(isError: inputData.isError)
    }
    
}

extension TextFieldView: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.validationTextField(tag: self.tag, text: textField.text)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
