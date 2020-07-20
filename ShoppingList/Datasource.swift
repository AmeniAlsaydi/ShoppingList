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
    
    // 1. reordering steps: handles ui
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true 
    }
    
    // 2. reordering
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        // get source item
        guard let sourceItem = itemIdentifier(for: sourceIndexPath) else { return}
        
        // SCENORIO 1: attempting to move to self
        
        guard sourceIndexPath != destinationIndexPath else {return}
        
        // get the destination item
        let destinationItem = itemIdentifier(for: destinationIndexPath)
        
        // get the current snapshot
        var snapshot = self.snapshot()
        
        // handle scenerio 2 and 3
        if let destinationItem = destinationItem {
            // get source index and destination index
            if let sourceIndex = snapshot.indexOfItem(sourceItem), let destinationIndex = snapshot.indexOfItem(destinationItem) {
                
                let isAfter = destinationIndex > sourceIndex && snapshot.sectionIdentifier(containingItem: sourceItem) == snapshot.sectionIdentifier(containingItem: destinationItem)
                
                // first delete the source item
                snapshot.deleteItems([sourceItem])
                
                // scenior 2
                if isAfter {
                    snapshot.insertItems([sourceItem], afterItem: destinationItem)
                }
                    
                    // scenerio 3
                else {
                    snapshot.insertItems([sourceItem], beforeItem: destinationItem)
                }
            }
        }
        else {
            //handle scenario 4
            //no index path at destination section
            //get section for destination index path
            let destinationSectionIdentifier = snapshot.sectionIdentifiers[destinationIndexPath.section]
            //delete item first
            snapshot.deleteItems([sourceItem])
            //append items
            snapshot.appendItems([sourceItem], toSection: destinationSectionIdentifier)
        }
        
        //apply changes
        apply(snapshot, animatingDifferences: false)
    }
}
