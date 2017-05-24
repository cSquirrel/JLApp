//
//  Model.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

fileprivate func ReadSafeJSONUrl(string: String) -> URL? {
    
    let result: URL?
    
    guard var urlComponents = URLComponents(string: string) else {
        return nil
    }
    
    if (urlComponents.scheme == nil) {
        urlComponents.scheme = "https"
    }
    
    result = urlComponents.url
    return result
}

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
    let displaySpecialOffer: String?
    
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
            let imageURL = ReadSafeJSONUrl(string: imageURLString) else {
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
        static let images = "images"
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
        
        guard
            let priceData = json[JsonKey.price] as? [String:Any],
            let price = priceData[JsonKey.priceNow] as? String,
            let title = json[JsonKey.title] as? String,
            let detailsData = json[JsonKey.details] as? [String:Any],
            let productInformation = detailsData[JsonKey.productInformation] as? String,
            let code = json[JsonKey.code] as? String  else {
                return nil
        }
        
        let displaySpecialOffer = json[JsonKey.displaySpecialOffer] as? String
        
        let imageURLs:[URL]
        if let media = json[JsonKey.media] as? [String:Any],
            let images = media[JsonKey.images] as? [String: Any],
            let imageURLStrings = images[JsonKey.urls] as? [String] {
            
            imageURLs = imageURLStrings.flatMap {ReadSafeJSONUrl(string: $0)}
            
        } else {
            imageURLs = []
        }
        
        let includedServices:[String]
        if let additionalServices = json[JsonKey.additionalServices] as? [String:Any],
            let services = additionalServices[JsonKey.includedServices] as? [String] {
            includedServices = services
        } else {
            includedServices = []
        }
        
        let features:[Feature]
        if let feats = json[JsonKey.features] as? [[String:Any]],
            feats.count > 0,
            let attributes = feats[0][JsonKey.attributes] as? [[String : Any]] {
                
            features = attributes.flatMap({ (element: [String : Any]) -> Feature? in
                guard
                    let name = element[JsonKey.name] as? String,
                    let value = element[JsonKey.value] as? String else {
                        return nil
                }
                let result = Feature(name: name, value: value)
                return result
            })
        } else {
            features = []
        }
        
        let result = JohnLewisProductDetails(title: title,
                                             imageURLs: imageURLs,
                                             price: price,
                                             productInformation: productInformation,
                                             displaySpecialOffer: displaySpecialOffer,
                                             includedServices: includedServices,
                                             code: code,
                                             features: features)
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
