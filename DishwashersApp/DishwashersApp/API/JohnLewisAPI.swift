//
//  JohnLewisAPI.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 22/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

struct JohnLewisProduct {
    
    // This is the product id that should be used to retrieve the product 
    // information for the product details screen.
    let productId: String
    
    // We can assume for this test that the price is in £s.
    let price: String
    
    // This is the title that should be used on the product grid page
    let title: String
    
    // The url of the image to show on the grid page.
    let imageURL: URL
}

class JohnLewisAPI: NSObject {

    func getProductsGrid() -> [JohnLewisProduct] {
        return [JohnLewisProduct(productId:"product_1",
                                 price: "9.99",
                                 title: "Product #1",
                                 imageURL: URL(string: "http://test.server.com/image1.png")!),
                JohnLewisProduct(productId:"product_2",
                                 price: "9.99",
                                 title: "Product #3",
                                 imageURL: URL(string: "http://test.server.com/image2.png")!),
            JohnLewisProduct(productId:"product_3",
                             price: "9.99",
                             title: "Product #3",
                             imageURL: URL(string: "http://test.server.com/image3.png")!)]
    }
}
