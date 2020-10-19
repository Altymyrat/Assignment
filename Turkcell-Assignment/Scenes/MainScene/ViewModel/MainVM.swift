//
//  MainVM.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class MainVM: BaseVM {
    private var responseModel: MainResponseModel {
        didSet{
            if !self.hasWritten {
                saveDetailToCoreData(responseModel.products)
            }
        }
    }
    private var detailModel = [DetailResponseModel]()
    
    init(model: MainResponseModel = MainResponseModel()) {
        responseModel = model
    }
    
    func fetchProductService() {
        NetworkManager.shared.request(router: Router.getProductList, completion: { [weak self] (result: Result<MainResponseModel>) in
            guard let self = self else { return }
            switch result {
            case .success(let result, let baseModel):
                if let model = result {
                    self.responseModel = model
                    if !self.hasWritten {
                        CoreDataManager.shared.saveProduct(data: self.responseModel.products)
                        self.hasWritten = true
                    }
                    self.saveDetailToCoreData(model.products)
                }
                if let model = baseModel as? MainResponseModel {
                    self.responseModel =  model
                }
                self.delegate?.succes()
            case .failure(let error):
                self.delegate?.failWith(error: error.localizedDescription)
            }
        })
    }
    
    var listCount: Int {
        return responseModel.products.count
    }
    
    func getProductItem(at index: Int) -> DetailVM {
        return DetailVM(model: responseModel.products[index])
    }
    
    private func saveDetailToCoreData(_ model: [DetailResponseModel]) {
        for index in model.enumerated() {
            NetworkManager.shared.request(router: Router.getDetail(id: index.element.product_id)) {[weak self] (result: Result<DetailResponseModel>) in
                guard self != nil else { return }
                switch result {
                case .success(let response, _ ):
                    if let model = response {
                        CoreDataManager.shared.saveDetail(data: model)
                    }
                case .failure(let error):
                    print("Error", error.localizedDescription)
                }
            }
        }
    }
    
    
    private var hasWritten: Bool {
        get {
            if let value = UserDefaults.standard.value(forKey: "hasWritten") as? Bool {
                return value
            } else {
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "hasWritten")
        }
    }
}
