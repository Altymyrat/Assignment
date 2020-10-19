//
//  Builder.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

final class ViewControllerBuilder {
    
    static func make(with type: ControllerType) -> UIViewController {
        switch type {
        case .main:
            let storyboard = UIStoryboard(name: MainSceneConstant.storyboard, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: MainSceneConstant.viewcontroller) as! MainVC
            return viewController
        case .detail:
            let storyboard = UIStoryboard(name: DetailSceneConstant.storyboard, bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier: DetailSceneConstant.viewcontroller) as! DetailVC
            return viewController
        }
        
    }
    
    enum ControllerType {
        case main
        case detail
    }
}
