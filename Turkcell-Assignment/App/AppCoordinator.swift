//
//  AppCoordinator.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

final class AppCoordinator {
    
    let window: UIWindow
    
    init() {
        window = UIWindow(frame: UIScreen.main.bounds)
    }
    
    func start() {
        let viewController = ViewControllerBuilder.make(with: .main)
        let navigationController = UINavigationController(rootViewController: viewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
