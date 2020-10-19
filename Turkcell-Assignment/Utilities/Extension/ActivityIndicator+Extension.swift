//
//  ActivityIndicator+Extension.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

extension ActivityIndicator {
     func topViewController() -> UIViewController {
        guard let rootController = (UIApplication.shared.windows.first?.rootViewController) else { return UIViewController() }
        if rootController is UINavigationController {
            if let navigationController = (rootController as? UINavigationController),
                let viewController = navigationController.visibleViewController {
                return viewController
            } else { return UIViewController() }
        } else if rootController.presentedViewController != nil {
            return rootController.presentedViewController!
        } else { return UIViewController() }
    }
}
