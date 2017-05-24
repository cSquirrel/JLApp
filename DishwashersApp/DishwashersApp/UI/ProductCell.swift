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
    
    func update(withProduct product: JohnLewisProduct, imagesProvider: ImagesProvider) {
        
        let imageURL = product.imageURL
        imagesProvider(imageURL, { [weak self] (loadedImage: UIImage?) in
            guard let li = loadedImage else {
                return
            }
            DispatchQueue.main.async {
                // Use the method from extension to reduce memory footprint
                self?.image.setImage(li)
            }
            
        })
        image.image = UIImage(named: "image_placeholder")
        productDescription.text = product.title
        price.text = product.price
    }
}
