//
//  SuperDataSource.swift
//  Library-Swift
//
//  Created by Daniel García Alvarado on 12/14/15.
//  Copyright © 2015 Dragonfly Labs. All rights reserved.
//

import UIKit

class SuperDataSourceAndDelegate<T>: NSObject, UITableViewDataSource, UITableViewDelegate {

    var _refreshDelegate : PullToRefreshDelegate?
    var _endlessDelegate : EndlessScrollDelegate?
    var _tableView : UITableView?
    var cellTypes : [Int] = []
    var items : [T] = []
    var isLoading = false
    var footerView : UIView?
    var currentPage : Int = 1
    let threshold = 100.0 // threshold from bottom of tableView
    
    required init(refreshDelegate: PullToRefreshDelegate, endlessScrollDelegate: EndlessScrollDelegate){
        super.init()
        self._refreshDelegate = refreshDelegate
        self._endlessDelegate = endlessScrollDelegate
        self.isLoading = false
        self.currentPage = 1
        self.setupEndlessControl()
    }

    func setupEndlessControl(){
        footerView = UIView(frame: CGRectMake(0,0,320,40))
        let indicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        indicator.tag = 10
        indicator.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        indicator.frame = CGRectMake(150, 5, 20, 20)
        indicator.hidesWhenStopped = true
        footerView?.addSubview(indicator)
    }
    
    func update(items: [T], appendBottom: Bool){
        if appendBottom {
           self.items.appendContentsOf(items)
        } else {
            self.items = items
        }
        if self.isLoading {
            self.isLoading = false
            (self._tableView?.tableFooterView?.viewWithTag(10) as! UIActivityIndicatorView).stopAnimating()
        }
        _tableView?.reloadData()
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        onSelectedItem(items[indexPath.row], position: indexPath.row)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return cellForRowAtIndexPath(indexPath, item: items[indexPath.row] as T)
    }

    func cellForRowAtIndexPath(indexPath: NSIndexPath, item: T) -> UITableViewCell{
        preconditionFailure("Method not implemented")
    }
    
    func onSelectedItem(item: T, position: Int?){
        preconditionFailure("Method not implemented")
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if items.count > 0 {
            let contentOffset = scrollView.contentOffset.y
            let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
        
            if !isLoading && (maximumOffset - contentOffset <= CGFloat(threshold)) {
                self.startEndlessScrolling()
            }
        }
    }

    func startEndlessScrolling(){
        self.isLoading = true
        self._tableView?.tableFooterView = footerView
        (self._tableView?.viewWithTag(10) as! UIActivityIndicatorView).startAnimating()
        self._endlessDelegate?.onLoadMoreItems(currentPage++)
    }
}
