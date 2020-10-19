//
//  NetworkRouter.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

enum Router {
    case getProductList
    case getDetail(id: String)
    
    private static let baseURLString = "https://s3-eu-west-1.amazonaws.com/developer-application-test/cart"
    
    private enum HTTPMethod {
        case get
        case post
        case put
        case delete
        
        var value: String {
            switch self {
            case .get: return "GET"
            case .post: return "POST"
            case .put: return "PUT"
            case .delete: return "DELETE"
            }
        }
    }
    
    private var method: HTTPMethod {
        switch self {
        case .getProductList:
            return .get
        case .getDetail:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getProductList:
            return "/list"
        case .getDetail(let id):
            return "/\(id)/detail"
        }
    }
    
    func request() throws -> URLRequest {
        let urlString = "\(Router.baseURLString)\(path)"
        
        guard let url = URL(string: urlString) else {
            throw ErrorType.parseUrlFail
        }
        
        var request = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 120)
        request.httpMethod = method.value
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        switch self {
        case .getProductList:
            return request
        case .getDetail:
            return request
        }
    }
    
    enum ProcessType {
        case product
        case detail
    }
    
    var type: ProcessType {
        switch self {
        case .getProductList:
            return .product
        case .getDetail:
            return .detail
        }
    }
}
