//
//  ServicesListViewController.swift
//  VkTestApp
//
//  Created by Khachatryan Arsen on 26.03.2024.
//

import UIKit
import WebKit

protocol ServicesListViewDelegate: AnyObject {
    func reloadTableView()
}

final class ServicesListViewController: UIViewController {
        
    let viewModel = ServicesListViewModel()
    
    let tableView = ServicesListTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDelegate()
        configureTableView()

    }

}

extension ServicesListViewController: UITableViewDelegate,  UITableViewDataSource{
    
    func configureTableView() {
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(viewModel.numberOfRows())
        return viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ServiceTableViewCell()
        
        let paramsForCell = viewModel.fetchServiceForRow(for: indexPath.row)
        
        cell.setUIs(iconStr: paramsForCell[0], title: paramsForCell[1], description: paramsForCell[2], linkStr: paramsForCell[3])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return viewModel.heightForRow()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let url = URL(string: viewModel.fetchLinkForSelectedCell(for: indexPath.row))
                
        UIApplication.shared.open(url!)
        
    }
    
}

extension ServicesListViewController: ServicesListViewDelegate {
    
    func configureDelegate() {
        viewModel.delegate = self
    }
    
    func reloadTableView() {
        tableView.reloadData()
    }
    
}
