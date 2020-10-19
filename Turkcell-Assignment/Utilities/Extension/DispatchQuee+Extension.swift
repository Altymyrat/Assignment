//
//  DispatchQuee+Extension.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 19.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

extension DispatchQueue {

    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}
