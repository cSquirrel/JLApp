//
//  ProductPhotosCarousel.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 24/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

@IBDesignable class ProductPhotosCarousel: DesignableView {

    @IBOutlet weak var productImageView: UIImageView!
    
    func loadImages(_ productImages: [URL], withImagesProvider imageProvider: ImagesProvider) {
        
        guard let firstImageURL = productImages.first else {
            return
        }
        
        imageProvider(firstImageURL) { (productImage: UIImage?) in
            
            guard let img = productImage else {
                return
            }
            DispatchQueue.main.async { [unowned self] in
                self.productImageView.image = img
            }
        }
    }
}
