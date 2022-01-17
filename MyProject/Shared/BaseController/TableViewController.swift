//
//  TableViewController.swift
//  MyProject
//
//  Created by Lê Hoàng Anh on 16/01/2022.
//  Copyright © 2022 Hoàng Anh. All rights reserved.
//

import Foundation

class TableViewController: ViewController {
    
    private(set) var navigationView: UIView!
    
    private(set) var navigationBarSeparator: UIView!
    
    private(set) var titleLabel: Label!
    
    private(set) var backButton: UIButton!
    
    private(set) var tableView: UITableView!
    
    var showNavigationBarBottomLine: Bool = false {
        didSet {
            navigationBarSeparator.isHidden = !showNavigationBarBottomLine
        }
    }
    
    override var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    let isEmptyData = PublishSubject<Bool>()
    
    override func setupView() {
        super.setupView()
        
        navigationView = UIView(backgroundColor: .white)
        view.addSubview(navigationView)
        navigationView.topAnchor == view.safeAreaLayoutGuide.topAnchor
        navigationView.horizontalAnchors == view.horizontalAnchors
        navigationView.heightAnchor == 60
        
        navigationBarSeparator = UIView(backgroundColor: .separator)
        navigationView.addSubview(navigationBarSeparator)
        navigationBarSeparator.bottomAnchor == navigationView.bottomAnchor
        navigationBarSeparator.horizontalAnchors == navigationView.horizontalAnchors
        navigationBarSeparator.heightAnchor == 1
        
        titleLabel = Label(font: .systemFont(ofSize: 17, weight: .bold))
        navigationView.addSubview(titleLabel)
        titleLabel.centerAnchors == navigationView.centerAnchors
        
        backButton = UIButton()
        navigationView.addSubview(backButton)
        backButton.leadingAnchor == navigationView.leadingAnchor
        backButton.verticalAnchors == navigationView.verticalAnchors
        backButton.widthAnchor == 60
        
        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)
        tableView.topAnchor == navigationView.bottomAnchor
        tableView.horizontalAnchors == view.horizontalAnchors
        tableView.bottomAnchor == view.safeAreaLayoutGuide.bottomAnchor
        
        view.backgroundColor = .white
        navigationBarSeparator.isHidden = true
        
        backButton.setImage(UIImage(named: "ic_back"), for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        
        tableView.separatorStyle = .none
        tableView.tableHeaderView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: .leastNonzeroMagnitude)))
        tableView.tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: CGFloat.leastNonzeroMagnitude, height: .leastNonzeroMagnitude)))
    }
    
    override func observeModel() {
        super.observeModel()
        
        isEmptyData
            .asDriverOnErrorJustComplete()
            .drive(isEmpyDataBinder)
            .disposed(by: rx.disposeBag)
    }
    
    func viewForEmptyDataOfTableView() -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: view.bounds.size.height))
        label.text = "Không có dữ liệu"
        label.textColor = .primary
        label.textAlignment  = .center
        return label
    }
    
    private func setNoDataView() {
        tableView.backgroundView = viewForEmptyDataOfTableView()
    }
    
    private func removeNoDataView() {
        tableView.backgroundView  = nil
    }
    
    @objc
    func backAction() {
        navigationController?.popViewController(animated: true)
    }
}

private extension TableViewController {
    
    var isEmpyDataBinder: Binder<Bool> {
        return Binder(self) { viewController, emptyData in
            if emptyData {
                viewController.setNoDataView()
            } else {
                viewController.removeNoDataView()
            }
        }
    }
}
