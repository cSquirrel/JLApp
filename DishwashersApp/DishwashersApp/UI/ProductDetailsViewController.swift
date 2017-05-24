//
//  ProductDetailsViewController.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    var productDetails: JohnLewisProductDetails!
    var imagesProvider:ImagesProvider?
    
    @IBOutlet weak var productDetailsView: ProductDetailsView!
}

extension ProductDetailsViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = productDetails.title
        productDetailsView.updateView(productDetails: productDetails, imagesProvider: imagesProvider)
    }


}
