//
//  Model.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

public struct JohnLewisProduct {
    
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

