//
//  NetworkError.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

enum ErrorType: Error {
    case parseUrlFail
    case notFound
    case validationError
    case serverError
    case defaultError
    case newOne
    
    case emptyCoreData
    
    var errorDescription: String? {
        switch self {
        case .parseUrlFail:
            return "Cannot initial URL object."
        case .notFound:
            return "Not Found"
        case .validationError:
            return "Validation Errors"
        case .serverError:
            return "Internal Server Error"
        case .defaultError:
            return "Something went wrong."
        case .emptyCoreData:
            return "Core data is empty"
        case newOne:
            return "new added case"
        }
    }
}

enum Result<T> {
    case success(data: T?, BaseModel?)
    case failure(error: Error)
}
