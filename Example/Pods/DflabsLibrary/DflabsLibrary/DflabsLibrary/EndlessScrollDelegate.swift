//
//  EndlessScrollDelegate.swift
//  Library-Swift
//
//  Created by Daniel García Alvarado on 12/14/15.
//  Copyright © 2015 Dragonfly Labs. All rights reserved.
//

import UIKit

public protocol EndlessScrollDelegate: NSObjectProtocol {

    func onLoadMoreItems(currentPage: Int?)
}
