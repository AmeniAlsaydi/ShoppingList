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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//            1. Get the current snapshot.
            var snapshot = self.snapshot()
            
//            2. Get the item using itemIdentifier(for: ) method of the data source.
            if let item = itemIdentifier(for: indexPath) { // itemIdentifier is on the datasource 
//            3. Delete the items from the snapshot.

                snapshot.deleteItems([item])
            }
//            4. Apply the snapshot (apply changes to the datasource which in turn update the table view)
            apply(snapshot, animatingDifferences: true)
            
        }
    }
}
