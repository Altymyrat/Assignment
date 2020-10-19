//
//  MainResponseModel.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class MainResponseModel: BaseModel {
    var products: [DetailResponseModel] = [DetailResponseModel]()
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
    }

    override init() {
        super.init()
    }
    
    convenience init( products: [DetailResponseModel] = [DetailResponseModel]()){
        self.init()
        self.products = products
    }
    
    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        
        let values = try decoder.container(keyedBy: CodingKeys.self)
        products = try values.decodeIfPresent([DetailResponseModel].self, forKey: .products)!
    }
}
