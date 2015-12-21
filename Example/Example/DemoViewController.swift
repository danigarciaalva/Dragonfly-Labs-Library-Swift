//
//  DemoViewController.swift
//  Library-Swift
//
//  Created by Daniel García Alvarado on 11/23/15.
//  Copyright © 2015 Dragonfly Labs. All rights reserved.
//

import UIKit
import DflabsLibrary

class DemoViewController: UIViewController, PullToRefreshDelegate, EndlessScrollDelegate{

    @IBOutlet weak var viewTableContainer: UIView!
    var delegate : FruitDataSourceDelegate?
    var superTableView : SuperTableView<Fruit>?
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = FruitDataSourceDelegate(refreshDelegate: self, endlessScrollDelegate: self)
        
        superTableView = SuperTableView<Fruit>(inView: self.view, superDataSourceAndDelegate: delegate, withNavigationBar: true)
        self.viewDidLayoutSubviews()
        superTableView?.startRefreshing()
    }
    
    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.superTableView!.contentInset = UIEdgeInsetsMake(y, 0, 0, 0)
        }
    }
    
    func onLoadMoreItems(currentPage: Int?) {
        Utils.delay(3.0) { () -> () in
            var fruits : [Fruit] = []
            for i in 1..<10 {
                fruits.append(Fruit(name: "Fruit \(i)"))
            }
            self.delegate?.update(fruits, appendBottom: true)
        }
    }
    
    
    func onRefresh() {
        Utils.delay(3.0) { () -> () in
            var fruits : [Fruit] = []
            for i in 1..<10 {
                fruits.append(Fruit(name: "Fruit \(i)"))
            }
            self.delegate?.update(fruits, appendBottom: false)
            self.superTableView?.endRefreshing()
        }
    }
}
