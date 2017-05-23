//
//  ProductCell.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {

    static let reuseIdentifier = "ProductCell"
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var price: UILabel!
    
}

extension ProductCell {
    
    func update(withProduct product: JohnLewisProduct) {
        
        image.image = UIImage(named: "image_placeholder")
        productDescription.text = product.title
        price.text = product.price
    }
}
