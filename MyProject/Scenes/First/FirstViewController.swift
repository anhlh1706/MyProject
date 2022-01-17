//
//  FirstViewController.swift
//  Base
//
//  Created by Hoàng Anh on 29/07/2020.
//  Copyright © 2020 Hoàng Anh. All rights reserved.
//

import UIKit
import Anchorage

final class FirstViewController: ViewController {

    let tableView = UITableView(frame: .zero, style: .plain)
    
    let searchController = UISearchController()
    
    override var viewModel: ViewModel {
        storedViewModel as! ViewModel
    }

    override func setupView() {
        title = "Repository search"
        
        view.addSubview(tableView)
        tableView.edgeAnchors == view.edgeAnchors
        
        tableView.tableFooterView = UIView()
        tableView.keyboardDismissMode = .onDrag
        tableView.register(cell: IconDoubleTextTableCell.self)
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    override func observeModel() {
        super.observeModel()
        
        let input = ViewModel.Input(searchKey: searchController.searchBar.rx.text.orEmpty.asDriver())
        let output = viewModel.transform(input)
        
        output.dataResponse.drive(tableView.rx.items(cellIdentifier: IconDoubleTextTableCell.identifier(), cellType: IconDoubleTextTableCell.self)) { row, element, cell in
            cell.render(title: element.name, subtitle: element.fullname, icon: nil, iconUrl: element.owner.avatarUrl)
        }.disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected
            .asDriver()
            .drive(onNext: { [weak tableView] indexPath in
                tableView?.cellForRow(at: indexPath)?.pulsate()
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            }).disposed(by: rx.disposeBag)
    }
}
