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
    var networkServicesProvider: MockNetworkServicesProvider!
    
    override func setUp() {
        super.setUp()
        
        networkServicesProvider = MockNetworkServicesProvider()
        let e = MockNetworkOperationsExecutor()
        api = JohnLewisAPI(networkServicesProvider, executor: e)
    }
    
    override func tearDown() {
        super.tearDown()
        api = nil
    }
    
    func testGetProductsGrid() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "products_from_server")!
        networkServicesProvider.mockDataToReturn = jsonData
        
        var returnedProducts:[JohnLewisProduct] = []
        let shouldReturnProducts = expectation(description: "Should return products")
        let result:JohnLewisAPI.GetProductsGridResult = {(prods: [JohnLewisProduct]) in
            returnedProducts = prods
            shouldReturnProducts.fulfill()
        }
        
        // execute
        api.getProductsGrid(result:result)
        wait(for: [shouldReturnProducts], timeout: 2)
        
        // verify
        XCTAssertEqual(returnedProducts.count, 20)
    }
    
}
