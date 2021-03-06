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
    
}

extension ProductPhotosCarousel {
    
    func loadImages(_ productImages: [URL], withImagesProvider imageProvider: ImagesProvider) {
        
        guard let firstImageURL = productImages.first else {
            return
        }
        
        imageProvider(firstImageURL) { (productImage: UIImage?) in
            
            guard let img = productImage else {
                return
            }
            DispatchQueue.main.async { [weak self] in
                // Use the method from extension to reduce memory footprint
                self?.productImageView.setImage(img)
            }
        }
    }
}
