//
//  JohnLewisProductTests.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import XCTest
@testable import DishwashersApp

class JohnLewisProductTests: XCTestCase {

    private let createMockProduct = { (productId: String) -> [String: Any?] in
        
        let result:[String: Any?] = ["productId":productId,
                                     "price": [
                                        "now": "9.99 \(productId)"
                                    ],
                                    "title": "Product \(productId)",
                                    "image": "http://test.server.com/image_\(productId).png"]
        return result
        
    }
    
    // MARK: -
    func testCreateProduct() {
        
        // prepare
        let productAsJson = createMockProduct("product_id_1")
        
        // execute
        let result = JohnLewisProduct.createProduct(fromJson: productAsJson)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.productId, "product_id_1")
        XCTAssertEqual(result?.price, "9.99 product_id_1")
        XCTAssertEqual(result?.title, "Product product_id_1")
        XCTAssertEqual(result?.imageURL, URL(string: "http://test.server.com/image_product_id_1.png")!)
    }
    
    func testCreateProduct_NoProductId() {
        
        // prepare
        var productAsJson = createMockProduct("product_id_1")
        productAsJson.removeValue(forKey: "productId")
        
        // execute
        let result = JohnLewisProduct.createProduct(fromJson: productAsJson)
        
        // verify
        XCTAssertNil(result)
    }
    
    func testCreateProduct_NoPrice() {
        
        // prepare
        var productAsJson = createMockProduct("product_id_1")
        productAsJson.removeValue(forKey: "price")
        
        // execute
        let result = JohnLewisProduct.createProduct(fromJson: productAsJson)
        
        // verify
        XCTAssertNil(result)
    }
    
    func testCreateProduct_NoTitle() {
        
        // prepare
        var productAsJson = createMockProduct("product_id_1")
        productAsJson.removeValue(forKey: "title")
        
        // execute
        let result = JohnLewisProduct.createProduct(fromJson: productAsJson)
        
        // verify
        XCTAssertNil(result)
    }

    func testCreateProduct_NoImage() {
        
        // prepare
        var productAsJson = createMockProduct("product_id_1")
        productAsJson.removeValue(forKey: "image")
        
        // execute
        let result = JohnLewisProduct.createProduct(fromJson: productAsJson)
        
        // verify
        XCTAssertNil(result)
    }

    func testCreateProducts() {
        
        // prepare
        let productsAsJson = [createMockProduct("product_id_1"),
                              createMockProduct("product_id_2")]
        
        // execute
        let result = JohnLewisProduct.createProducts(fromJson: productsAsJson)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.count, 2)
        
        XCTAssertEqual(result?[0].productId, "product_id_1")
        XCTAssertEqual(result?[0].price, "9.99 product_id_1")
        XCTAssertEqual(result?[0].title, "Product product_id_1")
        XCTAssertEqual(result?[0].imageURL, URL(string: "http://test.server.com/image_product_id_1.png")!)

        XCTAssertEqual(result?[1].productId, "product_id_2")
        XCTAssertEqual(result?[1].price, "9.99 product_id_2")
        XCTAssertEqual(result?[1].title, "Product product_id_2")
        XCTAssertEqual(result?[1].imageURL, URL(string: "http://test.server.com/image_product_id_2.png")!)

    }
    
    func testParseProductsAsJsonData() {
    
        // prepare 
        let jsonData = TestUtils.loadJSONData(fileName: "two_simple_products")!
        
        // execute
        let result = JohnLewisProduct.parse(productsAsJsonData: jsonData)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 2)
        
        XCTAssertEqual(result[0].productId, "product_id_1")
        XCTAssertEqual(result[0].price, "9.99 product_id_1")
        XCTAssertEqual(result[0].title, "Product product_id_1")
        XCTAssertEqual(result[0].imageURL, URL(string: "http://test.server.com/image_product_id_1.png")!)
        
        XCTAssertEqual(result[1].productId, "product_id_2")
        XCTAssertEqual(result[1].price, "9.99 product_id_2")
        XCTAssertEqual(result[1].title, "Product product_id_2")
        XCTAssertEqual(result[1].imageURL, URL(string: "http://test.server.com/image_product_id_2.png")!)
        
    }
    
    func testParseMultipleProductsFromServer() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "products_from_server")!
        
        // execute
        let result = JohnLewisProduct.parse(productsAsJsonData: jsonData)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result.count, 20)
        
    }

}
