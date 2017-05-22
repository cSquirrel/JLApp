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
        api = JohnLewisAPI()
    }
    
    override func tearDown() {
        super.tearDown()
        api = nil
    }
    
    func testGetProductsGrid() {
        
        // prepare
        
        // execute
        let result = api.getProductsGrid()
        
        // verify
        XCTAssertEqual(result.count, 3)
    }
    
}
