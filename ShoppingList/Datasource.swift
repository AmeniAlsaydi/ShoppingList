//
//  Datasource.swift
//  ShoppingList
//
//  Created by Amy Alsaydi on 7/15/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import Foundation
import UIKit

// conforms to UITableViewDataSource so we have access to datasource functions such as titleForHeaderInSection 
class DataSource: UITableViewDiffableDataSource<Category, Item> {
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if Category.allCases[section] == .shoppingCart {
            return "🛒" + Category.allCases[section].rawValue
        }
        else {
            return Category.allCases[section].rawValue
        }
    }  
}
