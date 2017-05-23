//
//  ProductDetailsViewController.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    var selectedProduct: JohnLewisProduct!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = selectedProduct.title
        
    }


}
