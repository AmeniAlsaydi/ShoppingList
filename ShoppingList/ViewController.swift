//
//  ViewController.swift
//  ShoppingList
//
//  Created by Amy Alsaydi on 7/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var tableView: UITableView!
    private var dataSource: DataSource! // is the subclass we created
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        configureDataSource()
        configureNavBar()
    }


    private func configureNavBar() {
        navigationItem.title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
    }
    
    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemGroupedBackground
        
        // register the cell
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
  
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(item.name)"
            return cell
        })
        
        // set up type of animation
        dataSource.defaultRowAnimation = .fade
        
        // set up initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Category, Item>() // must match the datasource type
        
        // populate snapshot with sections and items for each section
        // Case iterable allows us to iterate through all the cases of an emum
        
        for category in Category.allCases {
            // filter the testData() [items] fpr that particular category's item
            let items = Item.testData().filter { $0.category == category }
            snapshot.appendSections([category]) // add section to table view
            snapshot.appendItems(items)
        }
        
        // add datasource to snapshot
        dataSource.apply(snapshot, animatingDifferences: true)
        
    }
    
    @objc private func toggleEditState() {
        
    }
    
    @objc private func presentAddVC() {
      // TODO:
        // 1. create a AddItemViewController.swift file
        // 2. add a view controller object to story board
        // 3. add 2 textfeilds (item name + price)
        // 4. add a picker view to manage category
        // 5. user is able add a new item and submit it
        // 6. use any communication paradigm to get info from addVC back to shopping list VC

    }
}

