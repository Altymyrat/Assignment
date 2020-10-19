//
//  NetworkTest.swift
//  Turkcell-AssignmentTests
//
//  Created by M.J. on 17.10.2020.
//  Copyright © 2020 M.J. All rights reserved.
//

import XCTest
@testable import Turkcell_Assignment

class NetworkTest: XCTestCase {

    func testProduct() {
        let expectation = self.expectation(description: "product")
        var product: MainResponseModel?
        NetworkManager.shared.request(router: Router.getProductList) { (result: Result<MainResponseModel>) in
            switch result {
            case .success(let contactList):
                product = contactList
            default:
                break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        
        XCTAssertNotNil(product)
    }
    
    func testProductDetail() {
        
        let expectation = self.expectation(description: "productDetail")
        let id = "2"
        
        var detail: DetailResponseModel?
        NetworkManager.shared.request(router: Router.getDetail(id: id)) { (result: Result<DetailResponseModel>) in
            switch result {
            case .success(let item):
                detail = item
            default:
                break
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
        XCTAssertEqual(detail?.product_id, id)
    }
}
