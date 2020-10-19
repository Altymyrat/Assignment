//
//  MainSpecsTest.swift
//  Turkcell-AssignmentTests
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import XCTest
@testable import Turkcell_Assignment

class MainSpecsTest: XCTestCase {
    
    var mainViewModel: MainVM?
    
    override func setUp() {
        super.setUp()
        let detailModel = DetailResponseModel(product_id: "1",
                                              name: "apple",
                                              price: 20,
                                              image: "image.png")
        let detailModel2 = DetailResponseModel(product_id: "2",
                                               name: "beef",
                                               price: 50,
                                               image: "beef.svg")
        let mainModel = MainResponseModel(products: [detailModel,detailModel2])
        mainViewModel = MainVM(model: mainModel)
    }
    
    override func tearDown() {
        mainViewModel = nil
        super.tearDown()
    }
    
    func testMainProductSpec() {
        guard let viewModel = mainViewModel else { return }
        
        XCTAssertEqual(viewModel.listCount, 2)
        
        let product = viewModel.getProductItem(at: 0)
        
        XCTAssertEqual(product.name, "apple")
        XCTAssertEqual(product.productId, "1")
        XCTAssertEqual(product.imageUrl, "image.png")
        XCTAssertEqual(product.price, 20)
        
        let product2 = viewModel.getProductItem(at: 1)
        
        XCTAssertNotEqual(product2.name, "onion")
        XCTAssertNotEqual(product2.price, 40)
        XCTAssertNotEqual(product2.productId, "3")
        XCTAssertNotEqual(product2.imageUrl, "beef.png")
    }
}
