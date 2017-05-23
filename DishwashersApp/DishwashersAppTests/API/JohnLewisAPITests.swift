//
//  JohnLewisAPITests.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 22/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import XCTest
@testable import DishwashersApp

class JohnLewisAPITests: XCTestCase {
    
    var api: JohnLewisAPI!
    
    override func setUp() {
        super.setUp()
        
        let sp = MockNetworkServicesProvider()
        let e = MockNetworkOperationsExecutor()
        api = JohnLewisAPI(sp, executor: e)
    }
    
    override func tearDown() {
        super.tearDown()
        api = nil
    }
    
    func testGetProductsGrid() {
        
        // prepare
        var products:[JohnLewisProduct] = []
        let returnProducts = expectation(description: "Should return products")
        let result:JohnLewisAPI.GetProductsGridResult = {(prods: [JohnLewisProduct]) in
            products = prods
            returnProducts.fulfill()
        }
        
        // execute
        api.getProductsGrid(result:result)
        wait(for: [returnProducts], timeout: 2)
        
        // verify
        XCTAssertEqual(products.count, 3)
    }
    
}
