//
//  Utils.swift
//  Library-Swift
//
//  Created by Daniel García Alvarado on 12/15/15.
//  Copyright © 2015 Dragonfly Labs. All rights reserved.
//

import UIKit

class Utils: NSObject {

    class func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
}
