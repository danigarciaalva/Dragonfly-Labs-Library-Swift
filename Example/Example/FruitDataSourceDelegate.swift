//
//  FruitDataSourceDelegate.swift
//  Library-Swift
//
//  Created by Daniel García Alvarado on 12/15/15.
//  Copyright © 2015 Dragonfly Labs. All rights reserved.
//

import UIKit

class FruitDataSourceDelegate: SuperDataSourceAndDelegate<Fruit>{
    
    required init(refreshDelegate: PullToRefreshDelegate, endlessScrollDelegate: EndlessScrollDelegate) {
        super.init(refreshDelegate: refreshDelegate, endlessScrollDelegate: endlessScrollDelegate)
    }
    
    override func cellForRowAtIndexPath(indexPath: NSIndexPath, item: Fruit) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        cell.textLabel?.text = item.name
        return cell
    }
    
    override func onSelectedItem(item: Fruit, position: Int?) {
        
    }
}
