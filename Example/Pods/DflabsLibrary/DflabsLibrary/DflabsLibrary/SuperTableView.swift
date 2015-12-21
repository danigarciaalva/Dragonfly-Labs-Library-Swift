//
//  SuperTableView.swift
//  Library-Swift
//
//  Created by Daniel García Alvarado on 12/14/15.
//  Copyright © 2015 Dragonfly Labs. All rights reserved.
//

import UIKit

class SuperTableView<T: NSObject>: UITableView {

    var _refreshControl : UIRefreshControl?
    var _emptyView : UIView?
    var _superDataSourceDelegate : SuperDataSourceAndDelegate<T>?
    
    init(inView: UIView, superDataSourceAndDelegate: SuperDataSourceAndDelegate<T>?, withNavigationBar: Bool) {
        super.init(frame: inView.frame, style: .Plain)
        if withNavigationBar {
            self.frame = CGRectMake(inView.frame.origin.x, 64, inView.frame.size.width, inView.frame.size.height)
        }
        _superDataSourceDelegate = superDataSourceAndDelegate
        self.setup()
        superDataSourceAndDelegate?._tableView = self
        inView.addSubview(self)
    }
    
    func setup(){
        // Pull To Refresh Control
        self.backgroundColor = UIColor.yellowColor()
        self._refreshControl = UIRefreshControl()
        self._refreshControl!.addTarget(self, action: "onRefreshListener", forControlEvents: UIControlEvents.ValueChanged)
        self.addSubview(self._refreshControl!)
        
        self.delegate = _superDataSourceDelegate
        self.dataSource = _superDataSourceDelegate
        _superDataSourceDelegate?._tableView = self
    }
    
    func onRefreshListener(){
        startRefreshing()
    }
    
    func startRefreshing(){
        self.setContentOffset(CGPointMake(0, -self._refreshControl!.frame.size.height), animated: true)
        self._refreshControl!.beginRefreshing()
        _superDataSourceDelegate?._refreshDelegate?.onRefresh()
    }
    
    func endRefreshing(){
        self._refreshControl!.endRefreshing()
        self.setContentOffset(CGPointMake(0, 0), animated: true)
    }
 
    func startBottomRefreshing() {
        self._superDataSourceDelegate?.startEndlessScrolling()
    }
    
    func endBottomRefreshing() {
        self._superDataSourceDelegate?.update([], appendBottom: true)
    }
}
