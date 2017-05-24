//
//  ProductDetailsView.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 24/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

@IBDesignable class ProductDetailsView: DesignableView {

    @IBOutlet weak var photosCarousel: ProductPhotosCarousel!
    @IBOutlet weak var productInfoView: ProductInfoView!
    @IBOutlet weak var productInfoLabel: UILabel!

    var imageProvider:ImagesProvider?
    var selectedProductDetails: JohnLewisProductDetails? {
        didSet {
            guard let details = selectedProductDetails else {
                return
            }
            updateView(productDetails: details)
        }
    }
    
    private func updateView(productDetails: JohnLewisProductDetails) {
        
        if let imgProvider = imageProvider {
            let productImages = productDetails.imageURLs
            photosCarousel.loadImages(productImages, withImagesProvider:imgProvider)
        }
        
        //
        // NOTE: Price formatting deserves own formatter.
        //
        // If the price read from the API would be equipped with al the attributes 
        // it would be worth to have a designated "Price" model object and
        // PriceFormatter class which would format the price according to the value and currency code
        productInfoView.price.text = "£\(productDetails.price)"
        
        productInfoView.specialOffer.text = productDetails.displaySpecialOffer ?? ""
        
        let includedServices = productDetails.includedServices.joined(separator: "\n")
        productInfoView.includedServices.text = includedServices
        
        let productInfo = "Product code: \(productDetails.code)\n\(productDetails.productInformation)"
        productInfoLabel.text = productInfo
    }
    
}
