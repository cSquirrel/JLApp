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
        let baseURL = URL(string:"http://bbc.co.uk/api/")!
        let config = JohnLewisAPIConfig(networkProvider: MockNetworkServicesProvider(),
                                        networkExecutor: MockNetworkOperationsExecutor(),
                                        baseURL: baseURL,
                                        apiKey: "dummy_key")
    
        // execute
        let result = config.createEndpointURL(servicePath: "service/path")
        
        // verify
        let components = URLComponents.init(url: result, resolvingAgainstBaseURL: false)
        XCTAssertEqual(components?.host, "bbc.co.uk")
        XCTAssertEqual(components?.scheme, "http")
        XCTAssertEqual(components?.path, "/api/service/path")
        XCTAssertNil(components?.queryItems)
    }
    
    func testCreateEndpointURL_WithQueryParams() {
        
        // prepare
        let baseURL = URL(string:"http://bbc.co.uk/api/")!
        let config = JohnLewisAPIConfig(networkProvider: MockNetworkServicesProvider(),
                                        networkExecutor: MockNetworkOperationsExecutor(),
                                        baseURL: baseURL,
                                        apiKey: "dummy_key")
        
        // execute
        let result = config.createEndpointURL(servicePath: "service/path", queryParams:["key1":"value1",
                                                                                        "key2":"value2"])
        
        // verify
        let components = URLComponents.init(url: result, resolvingAgainstBaseURL: false)
        XCTAssertEqual(components?.host, "bbc.co.uk")
        XCTAssertEqual(components?.scheme, "http")
        XCTAssertEqual(components?.path, "/api/service/path")
        XCTAssertEqual(components?.queryItems?.count, 2)
        
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
                                        baseURL: URL(string:"http://bbc.co.uk/api")!,
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
        api.getProductsGrid(query: "mock_query", searchPageSize: 20, result:result)
        wait(for: [shouldReturnProducts], timeout: 2)
        
        // verify
        XCTAssertEqual(returnedProducts.count, 20)
    }
    
    func testGetProductsGrid_RequestedURL() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "products_from_server")!
        networkServicesProvider.mockDataToReturn = jsonData
        
        let shouldReturnProducts = expectation(description: "Should return products")
        let result:JohnLewisAPI.GetProductsGridResult = {(prods: [JohnLewisProduct]) in
            shouldReturnProducts.fulfill()
        }
        
        // execute
        api.getProductsGrid(query: "mock_query", searchPageSize: 20, result:result)
        wait(for: [shouldReturnProducts], timeout: 2)
        
        // verify
        let requestedURL = networkServicesProvider.lastRequestedURL
        XCTAssertNotNil(requestedURL)
        let components = URLComponents(url: requestedURL!, resolvingAgainstBaseURL: false)
        XCTAssertEqual(components?.host, "bbc.co.uk")
        XCTAssertEqual(components?.scheme, "http")
        XCTAssertEqual(components?.path, "/api/products/search")
        XCTAssertEqual(components?.queryItems?.count, 3)
        
        var queryParams:[String:String] = [:]
        components!.queryItems!.forEach { queryParams[$0.name] = $0.value }
        XCTAssertEqual(queryParams["key"], "dummy_key")
        XCTAssertEqual(queryParams["q"], "mock_query")
        XCTAssertEqual(queryParams["pageSize"], "20")
    }
    
    func testGetProductDetails() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "product_details_from_server")!
        networkServicesProvider.mockDataToReturn = jsonData

        var returnedProduct:JohnLewisProductDetails? = nil
        let shouldReturnProductDetails = expectation(description: "Should return product details")
        let productId = "123"
        let result:JohnLewisAPI.GetProductDetailsResult = {(prod: JohnLewisProductDetails) in
            returnedProduct = prod
            shouldReturnProductDetails.fulfill()
        }
        
        // execute
        api.getProductDetails(productId: productId, result: result)
        wait(for: [shouldReturnProductDetails], timeout: 2)
        
        // verify
        XCTAssertNotNil(returnedProduct)
    }
    
    func testGetProductDetails_RequestedURL() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "product_details_from_server")!
        networkServicesProvider.mockDataToReturn = jsonData
        
        let shouldReturnProductDetails = expectation(description: "Should return product details")
        let productId = "123"
        let result:JohnLewisAPI.GetProductDetailsResult = {(prod: JohnLewisProductDetails) in
            shouldReturnProductDetails.fulfill()
        }
        
        // execute
        api.getProductDetails(productId: productId, result: result)
        wait(for: [shouldReturnProductDetails], timeout: 2)
        
        // verify
        let requestedURL = networkServicesProvider.lastRequestedURL
        XCTAssertNotNil(requestedURL)
        let components = URLComponents(url: requestedURL!, resolvingAgainstBaseURL: false)
        XCTAssertEqual(components?.host, "bbc.co.uk")
        XCTAssertEqual(components?.scheme, "http")
        XCTAssertEqual(components?.path, "/api/products/123")
        XCTAssertEqual(components?.queryItems?.count, 1)
        
        var queryParams:[String:String] = [:]
        components!.queryItems!.forEach { queryParams[$0.name] = $0.value }
        XCTAssertEqual(queryParams["key"], "dummy_key")
    }
    
}
