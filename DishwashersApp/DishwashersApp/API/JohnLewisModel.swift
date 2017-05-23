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

public struct JohnLewisProductDetails {
 
    // The title of the product
    let title: String
    
    // The image urls returned here should be used on the product page.
    let imageURLs: [URL]
    
    // The now price is the price of the product, and should be assumed this price is in £
    // Price -> Now
    let price: String
    
    // Text to display in the product information
    //Details -> productInformation
    let productInformation: String
    
    // When data is present here, this is shown on the product page under the price
    let displaySpecialOffer: String
    
    // Guarantee information
    //additionalServices -> includedServices
    let includedServices: [String]
    
    // Product Code
    let code: String
    
    // Product Specification Name
    // Features[0] -> Attributes -> name
    // Value for the product specification
    // Features[0] -> Attributes ->value
    
    public struct Feature {
        let name: String
        let value: String
    }
    
    let features:[Feature]

}

// MARK: - Create from JSON

/**
 * NOTE:
 *
 * Since the model is defined by the API I don't see a problem with 
 * parsing JSON to model object here. 
 * Would the model be internal to the app I would extract the following 
 * extension to JohnLewisProductBuilder then
 * to keep the model JSON agnostic.
 */
extension JohnLewisProduct {
    
    enum JsonKey {
        static let products = "products"
        static let productId = "productId"
        static let price = "price"
        static let priceNow = "now"
        static let title = "title"
        static let imageURL = "image"
    }
    
    public static func createProduct(fromJson json: [String:Any?]) -> JohnLewisProduct? {
        
        guard let productId = json[JsonKey.productId] as? String,
            let priceData = json[JsonKey.price] as? [String:Any?],
            let price = priceData[JsonKey.priceNow] as? String,
            let title = json[JsonKey.title] as? String,
            let imageURLString = json[JsonKey.imageURL] as? String,
            let imageURL = URL(string: imageURLString) else {
                return nil
        }
        
        let result = JohnLewisProduct(productId: productId,
                                      price: price,
                                      title: title,
                                      imageURL: imageURL)
        return result
    }

    public static func createProducts(fromJson: Array<Any?>) -> [JohnLewisProduct]? {
        
        let result: [JohnLewisProduct]
        
        result = fromJson.flatMap({ (jsonElement: Any?) -> JohnLewisProduct? in
            
            guard let jsonDict = jsonElement as? [String:Any?] else {
                return nil
            }
            let product = createProduct(fromJson: jsonDict)
            return product
        })
        
        return result
    }
    
    public static func parse(productsAsJsonData jsonData: Data) -> [JohnLewisProduct] {
        
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let productsAsJsonObject = jsonObject as? Dictionary<String,Any>,
            let productsArray = productsAsJsonObject[JsonKey.products] as? Array<Any> else {
                return []
        }
        
        guard let products = createProducts(fromJson: productsArray) else {
            return []
        }
        
        return products
    }
    
}

extension JohnLewisProductDetails {
    
    enum JsonKey {
        static let title = "title"
        static let media = "media"
        static let image = "images"
        static let urls = "urls"
        static let price = "price"
        static let priceNow = "now"
        static let details = "details"
        static let productInformation = "productInformation"
        static let displaySpecialOffer = "displaySpecialOffer"
        static let additionalServices = "additionalServices"
        static let includedServices = "includedServices"
        static let code = "code"
        static let features = "features"
        static let attributes = "attributes"
        static let name = "name"
        static let value = "value"
    }
    
    public static func createProduct(fromJson json: [String:Any]) -> JohnLewisProductDetails? {
        
//        guard let productId = json[JsonKey.productId] as? String,
//            let priceData = json[JsonKey.price] as? [String:Any],
//            let price = priceData[JsonKey.priceNow] as? String,
//            let title = json[JsonKey.title] as? String,
//            let imageURLString = json[JsonKey.imageURL] as? String,
//            let imageURL = URL(string: imageURLString) else {
//                return nil
//        }
        
        let result = JohnLewisProductDetails(title: "",
                                             imageURLs: [],
                                             price: "",
                                             productInformation: "",
                                             displaySpecialOffer: "",
                                             includedServices: [""],
                                             code: "",
                                             features: [])
        return result
    }
    
    public static func parse(productsAsJsonData jsonData: Data) -> JohnLewisProductDetails? {
        
        guard
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let productsAsJsonObject = jsonObject as? [String:Any] else {
                return nil
        }
        
        guard let products = createProduct(fromJson: productsAsJsonObject) else {
            return nil
        }
        
        return products
    }
    
}

extension JohnLewisProductDetails.Feature {
    
}
