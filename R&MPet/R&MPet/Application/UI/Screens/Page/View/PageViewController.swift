//
//  PageViewController.swift
//  R&MPet
//
//  Created by Максим Сулим on 20.02.2024.
//

import UIKit
import RxSwift
import SnapKit

final class PageViewController: UIViewController {
    
    var viewModel: PageViewModel
    
    init(viewModel: PageViewModel) {
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
    
    private lazy var logoutButton: BaseButton = {
        let button = BaseButton()
        button.configure(style: .fill, title: "Logout")
        button.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
        return button
    }()
    
    private func setupView() {
        view.backgroundColor = .gray
        navigationItem.title = "Your page"
        view.addSubview(logoutButton)
        makeConstraint()
    }
    
    private func makeConstraint() {
        logoutButton.snp.makeConstraints { make in
            make.centerWithinMargins.equalToSuperview()
        }
    }
    
    @objc private func logoutTapped() {
        viewModel.events.onNext(.tappedLogout)
    }
    
    func render() {
        
    }
}
