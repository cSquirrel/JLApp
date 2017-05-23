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

    private let createMockProduct = { (productId: String) -> [String: Any] in
        
        let result:[String: Any] = ["productId":productId,
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

// MARK: -
class JohnLewisProductDetailsTests: XCTestCase {

    private let createMockProductDetails = { (productId: String) -> [String: Any] in
        
        let result:[String: Any] =
        [
            "title": "Product Title",
            "price": [
                "now": "549.00",
            ],
            "code": "ProductCode",
            "displaySpecialOffer": "Extra 3 years guarantee",
            "additionalServices": [
                "includedServices": ["2 year guarantee included"]
            ],
            "media": [
                "images": [
                    "urls": ["http://test.server/image1.png", "http://test.server/image2.png"]
                ]
            ],
            "details": [
                "productInformation": "Product Information"
            ],
            "features": [[
                "attributes": [
                    [
                        "name": "Dimensions",
                        "value": "H84.5 x W60 x D60cm"
                    ],
                    [
                        "name": "Number of Programs",
                        "value": "6"
                    ]
                ]
            ]]
        ]
        return result
        
    }
    
    // MARK: -
    func testCreateProductDetails() {
        
        // prepare
        let productAsJson = createMockProductDetails("product_id_1")
        
        // execute
        let result = JohnLewisProductDetails.createProduct(fromJson: productAsJson)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title,"Product Title")
        XCTAssertEqual(result?.price,"549.00")
        XCTAssertEqual(result?.productInformation,"Product Information")
        XCTAssertEqual(result?.displaySpecialOffer,"Extra 3 years guarantee")
        XCTAssertEqual(result?.includedServices.count,1)
        XCTAssertEqual(result?.includedServices[0], "2 year guarantee included")
        XCTAssertEqual(result?.code,"ProductCode")
        XCTAssertEqual(result?.imageURLs.count, 2)
        XCTAssertEqual(result?.imageURLs[0], URL(string:"http://test.server/image1.png"))
        XCTAssertEqual(result?.imageURLs[1], URL(string:"http://test.server/image2.png"))
        XCTAssertEqual(result?.features.count, 2)
        XCTAssertEqual(result?.features[0].name, "Dimensions")
        XCTAssertEqual(result?.features[0].value, "H84.5 x W60 x D60cm")
        XCTAssertEqual(result?.features[1].name, "Number of Programs")
        XCTAssertEqual(result?.features[1].value, "6")
    }
    
    func testParseProductsAsJsonData() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "simple_product")!
        
        // execute
        let result = JohnLewisProductDetails.parse(productsAsJsonData: jsonData)
        
        // verify
        XCTAssertNotNil(result)
        XCTAssertEqual(result?.title,"Product Title")
        XCTAssertEqual(result?.price,"549.00")
        XCTAssertEqual(result?.productInformation,"Product Information")
        XCTAssertEqual(result?.displaySpecialOffer,"Extra 3 years guarantee")
        XCTAssertEqual(result?.includedServices.count,1)
        XCTAssertEqual(result?.includedServices[0], "2 year guarantee included")
        XCTAssertEqual(result?.code,"ProductCode")
        XCTAssertEqual(result?.imageURLs.count, 2)
        XCTAssertEqual(result?.imageURLs[0], URL(string:"http://test.server/image1.png"))
        XCTAssertEqual(result?.imageURLs[1], URL(string:"http://test.server/image2.png"))
        XCTAssertEqual(result?.features.count, 2)
        XCTAssertEqual(result?.features[0].name, "Dimensions")
        XCTAssertEqual(result?.features[0].value, "H84.5 x W60 x D60cm")
        XCTAssertEqual(result?.features[1].name, "Number of Programs")
        XCTAssertEqual(result?.features[1].value, "6")
        
    }

    func testParseProductFromServer() {
        
        // prepare
        let jsonData = TestUtils.loadJSONData(fileName: "product_details_from_server")!
        
        // execute
        let result = JohnLewisProductDetails.parse(productsAsJsonData: jsonData)
        
        // verify
        XCTAssertNotNil(result)
        
    }
}
