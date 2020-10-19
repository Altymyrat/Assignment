//
//  NetworkManager.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    private let coreDatamanager = CoreDataManager.shared
    
    private let config: URLSessionConfiguration
    private let session: URLSession
    
    private init() {
        config = URLSessionConfiguration.default
        session = URLSession(configuration: config)
    }
    
    func request<T: Decodable>(router: Router, completion: @escaping (Result<T>) -> ()) {
        ActivityIndicator.shared.showIndicator()
        if Reachability.shared.isRaechInternet() {
            do {
                let task = try session.dataTask(with: router.request()) { (data, urlResponse, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            ActivityIndicator.shared.stopIndicator()
                            completion(Result<T>.failure(error: error))
                            return
                        }
                        if self.isSuccessCode(urlResponse) {
                            guard let data = data else {
                                ActivityIndicator.shared.stopIndicator()
                                completion(Result<T>.failure(error: ErrorType.defaultError))
                                return
                            }
                            
                            do {
                                let result = try JSONDecoder().decode(T.self, from: data)
                                ActivityIndicator.shared.stopIndicator()
                                completion(Result.success(data: result, nil))
                            } catch let error {
                                ActivityIndicator.shared.stopIndicator()
                                completion(Result.failure(error: error))
                            }
                        } else {
                            ActivityIndicator.shared.stopIndicator()
                            completion(Result.failure(error: ErrorType.serverError))
                        }
                    }
                }
                task.resume()
                
            } catch (let error) {
                ActivityIndicator.shared.stopIndicator()
                completion(Result<T>.failure(error: error))
            }
        } else {
            switch router.type {
            case .product:
                if !(coreDatamanager.total(ProductList.self) == 0) {
                    if let coreModel = coreDatamanager.fetch(ProductList.self) {
                        var mainCoreModel: [DetailResponseModel] = []
                        for index in coreModel.indices {
                            mainCoreModel.append(DetailResponseModel(product_id: coreModel[index].product_id,
                                                                     name: coreModel[index].name,
                                                                     price: Int(coreModel[index].price),
                                                                     image: coreModel[index].image))
                        }
                        completion(Result.success(data: nil, MainResponseModel(products: mainCoreModel)))
                        ActivityIndicator.shared.stopIndicator()
                        return
                    }
                }
                completion(Result.failure(error: ErrorType.emptyCoreData))
                ActivityIndicator.shared.stopIndicator()
            case .detail:
                if !(coreDatamanager.total(Detail.self) == 0) {
                    if let coreModel = coreDatamanager.fetch(Detail.self) {
                        var deatilCoreModel: [DetailResponseModel] = []
                        for index in coreModel.indices {
                            deatilCoreModel.append(DetailResponseModel(product_id: coreModel[index].product_id,
                                                                       name: coreModel[index].name,
                                                                       price: Int(coreModel[index].price),
                                                                       image: coreModel[index].image,
                                                                       description: coreModel[index].product_desc))
                        }
                        completion(Result.success(data: nil, MainResponseModel(products: deatilCoreModel)))
                        ActivityIndicator.shared.stopIndicator()
                        return
                    }
                }
                completion(Result.failure(error: ErrorType.emptyCoreData))
                ActivityIndicator.shared.stopIndicator()
            }
        }
    }
}
