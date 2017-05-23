//
//  JohnLewisAPITests.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 22/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import XCTest
@testable import DishwashersApp

class JohnLewisAPIConfigTests: XCTestCase {
    
    func testCreateEndpointURL() {
        
        // prepare
        let baseURL = URL(string:"http/bbc.co.uk/api/")!
        let config = JohnLewisAPIConfig(networkProvider: MockNetworkServicesProvider(),
                                        networkExecutor: MockNetworkOperationsExecutor(),
                                        baseURL: baseURL,
                                        apiKey: "dummy_key")
    
        // execute
        let result = config.createEndpointURL(servicePath: "service/path")
        
        // verify
        XCTAssertEqual(result.absoluteString, "http/bbc.co.uk/api/service/path")
    }
}

class JohnLewisAPITests: XCTestCase {
    
    var api: JohnLewisAPI!
    var networkServicesProvider: MockNetworkServicesProvider!
    
    override func setUp() {
        super.setUp()
        
        networkServicesProvider = MockNetworkServicesProvider()
        let e = MockNetworkOperationsExecutor()
        let config = JohnLewisAPIConfig(networkProvider: networkServicesProvider,
                                        networkExecutor: e,
                                        baseURL: URL(string:"http://bbc.co.uk")!,
                                        apiKey: "dummy_key")
        api = JohnLewisAPI(config)
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
        api.getProductsGrid(query: "mock_query", result:result)
        wait(for: [shouldReturnProducts], timeout: 2)
        
        // verify
        XCTAssertEqual(returnedProducts.count, 20)
    }
    
}
