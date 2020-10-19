//
//  DetailSpecsTest.swift
//  Turkcell-AssignmentTests
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import XCTest
@testable import Turkcell_Assignment

class DetailSpecsTest: XCTestCase {

    var detailVM: DetailVM?
    
    override func setUp() {
        super.setUp()
        let detailModel = DetailResponseModel(product_id: "2",
                                              name: "Onion",
                                              price: 6,
                                              image: "onion.jpeg",
                                              description: "Don't cry its just onions")
        detailVM = DetailVM(model: detailModel)
    }

    override func tearDown() {
        detailVM = nil
        super.tearDown()
    }
    
    func testDetailSpecs() {
        guard let viewModel = detailVM else { return }
        
        XCTAssertEqual(viewModel.name, "Onion")
        XCTAssertEqual(viewModel.productId, "2")
        XCTAssertEqual(viewModel.imageUrl, "onion.jpeg")
        XCTAssertEqual(viewModel.price, 6)
        XCTAssertEqual(viewModel.description, "Don't cry its just onions")
    }
}
