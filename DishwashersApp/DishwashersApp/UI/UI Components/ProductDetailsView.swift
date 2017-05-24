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
    
    var selectedProductDetails: JohnLewisProductDetails! {
        didSet {
            updateView()
        }
    }
    
    private func updateView() {
        
        let productImages = selectedProductDetails.imageURLs
        photosCarousel.loadImages(productImages, withImageLoader:NSObject())
        
        //
        // NOTE: Price formatting deserves own formatter.
        //
        // If the price read from the API would be equipped with al the attributes 
        // it would be worth to have a designated "Price" model object and
        // PriceFormatter class which would format the price according to the value and currency code
        productInfoView.price.text = "£\(selectedProductDetails.price)"
        
        productInfoView.specialOffer.text = selectedProductDetails.displaySpecialOffer ?? ""
        
        let includedServices = selectedProductDetails.includedServices.joined(separator: "\n")
        productInfoView.includedServices.text = includedServices
        
        let productInfo = "Product code: \(selectedProductDetails.code)\n\(selectedProductDetails.productInformation)"
        productInfoLabel.text = productInfo
    }
    
}
