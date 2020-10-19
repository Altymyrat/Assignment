//
//  DetailVM.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class DetailVM: BaseVM {
    private var responseModel: DetailResponseModel
    
    
    init(model: DetailResponseModel = DetailResponseModel()) {
        responseModel = model
    }
    
    func fetchDetailService(productId: String) {
        NetworkManager.shared.request(router: Router.getDetail(id: productId)) { [weak self] (result: Result<DetailResponseModel>) in
            guard let self = self else { return }
            switch result {
            case .success(let result, let baseModel):
                if let model = result {
                    self.responseModel = model
                }
                if let model = baseModel as? MainResponseModel {
                    for item in model.products {
                        if item.product_id == productId {
                            self.responseModel = item
                        }
                    }
                }
                self.delegate?.succes()
            case .failure(let error):
                self.delegate?.failWith(error: error.localizedDescription)
            }
        }
    }
    
    var productId: String {
        return responseModel.product_id
    }
    
    var price: Int {
        return responseModel.price
    }
    
    var name: String {
        return responseModel.name
    }
    
    var imageUrl: String {
        return responseModel.image
    }
    
    var description: String {
        return responseModel.description ?? ""
    }
}
