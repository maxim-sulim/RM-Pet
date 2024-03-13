//
//  MapViewController.swift
//  R&MPet
//
//  Created by Максим Сулим on 21.02.2024.
//

import UIKit
import RxSwift

final class MapViewController: UIViewController {
    
    var viewModel: MapViewModel
    private lazy var disposeBag: DisposeBag = DisposeBag()
    
    init(viewModel: MapViewModel) {
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
    
    private func setupView() {
        view.backgroundColor = .lightGray
        navigationItem.title = "Your map"
        startListenModel()
    }
    
    private func startListenModel() {
        viewModel.viewInputData.subscribe(onNext: { [weak self] inputData in
            self?.render(inputModel: inputData)
        }).disposed(by: disposeBag)
    }
    
    func render(inputModel: MapViewInputModel) {
        
    }
}
