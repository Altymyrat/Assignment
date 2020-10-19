//
//  NetworkManager+Extension.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

extension NetworkManager {
    func isSuccessCode(_ response: URLResponse?) -> Bool {
        guard let urlResponse = response as? HTTPURLResponse else {
            return false
        }
        return urlResponse.statusCode >= 200 && urlResponse.statusCode < 300
    }
}
