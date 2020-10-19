//
//  ActivityIndicatorManager.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import UIKit

class ActivityIndicator {
    static let shared = ActivityIndicator()
    private let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    func showIndicator() {
        configureIndicatorView()
        activityIndicator.startAnimating()
    }
    
    func stopIndicator() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            self.activityIndicator.removeFromSuperview()
        }
    }
    
    private func configureIndicatorView() {
        let topVCView = topViewController().view
        activityIndicator.frame = CGRect(x: 0.0, y: 0.0, width: 150.0, height: 150.0)
        activityIndicator.center = topVCView?.center ?? CGPoint(x: 0.0, y: 0.0)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .whiteLarge
        activityIndicator.color = .gray
        topVCView?.addSubview(activityIndicator)
    }
}

