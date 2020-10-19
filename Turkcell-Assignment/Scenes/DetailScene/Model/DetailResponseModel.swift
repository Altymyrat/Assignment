//
//  DetailResponseModel.swift
//  Turkcell-Assignment
//
//  Created by M.J. on 16.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import Foundation

class  DetailResponseModel: BaseModel {
    var product_id: String = ""
    var name: String = ""
    var price: Int = 0
    var image: String = ""
    var description: String?
    
    override init(){
        super.init()
    }
    
    convenience init(product_id: String = "", name: String = "", price: Int = 0, image: String = "", description: String = "") {
        self.init()
        self.product_id = product_id
        self.name = name
        self.price = price
        self.image = image
        self.description = description
    }
    
    enum CodingKeys: String, CodingKey {

        case product_id = "product_id"
        case name = "name"
        case price = "price"
        case image = "image"
        case description = "description"
    }

    required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
        let values = try decoder.container(keyedBy: CodingKeys.self)
        product_id = try values.decodeIfPresent(String.self, forKey: .product_id)!
        name = try values.decodeIfPresent(String.self, forKey: .name)!
        price = try values.decodeIfPresent(Int.self, forKey: .price)!
        image = try values.decodeIfPresent(String.self, forKey: .image)!
        description = try values.decodeIfPresent(String.self, forKey: .description)
    }
}
