//
//  CALayer+Extension.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

extension CALayer {
    
    func drawShadow(color: UIColor = .black, alpha: Float = 0.5, x: CGFloat = 0,  y: CGFloat = 2, blur:CGFloat = 4, spread: CGFloat = 0){
        shadowColor = color.cgColor
        shadowOpacity = alpha
        shadowOffset = CGSize(width: x, height: y)
        shadowRadius = blur / 2.0
        if spread == 0 {
            shadowPath = nil
            return
        }
        let dx = -spread
        let rect = bounds.insetBy(dx: dx, dy: dx)
        shadowPath = UIBezierPath(rect: rect).cgPath
    }
}
