//
//  ViewController+Extension.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

private var dataAssociationKey: UInt8 = 0

extension UIViewController {
    var data: Any? {
        get {
            return objc_getAssociatedObject(self, &dataAssociationKey) as Any?
        }
        set(newValue) {
            objc_setAssociatedObject(self, &dataAssociationKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}
