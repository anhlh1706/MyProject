//
//  ViewController.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 11/12/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewModel: BaseViewModel {
        storedViewModel
    }
    
    var storedViewModel: BaseViewModel
    
    let isLoading = PublishSubject<Bool>()
    
    init(viewModel: BaseViewModel? = nil) {
        storedViewModel = viewModel ?? BaseViewModel()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupInteraction()
        observeModel()
    }
    
    func setupView() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setupInteraction() { }
    
    func observeModel() {
        viewModel
            .loading
            .asDriver()
            .drive(isLoading)
            .disposed(by: rx.disposeBag)
        
        isLoading
            .distinctUntilChanged()
            .throttle(.milliseconds(300), scheduler: MainScheduler.instance)
            .asDriverOnErrorJustComplete()
            .drive(rx.isAnimating)
            .disposed(by: rx.disposeBag)
    }
}

extension Reactive where Base: ViewController {
    
    var isAnimating: RxSwift.Binder<Bool> {
      return Binder(base) { viewController, isVisible in
         if isVisible {
             viewController.showLoading()
         } else {
             viewController.hideLoading()
         }
      }
   }
    
}
