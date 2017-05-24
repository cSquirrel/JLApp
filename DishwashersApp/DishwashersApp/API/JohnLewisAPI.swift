//
//  JohnLewisAPI.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 22/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

struct JohnLewisAPIConfig {
    
    let networkProvider: NetworkServicesProvider
    let networkExecutor: NetworkOperationsExecutor
    let baseURL: URL
    let apiKey: String
    
    public func createEndpointURL(servicePath: String, queryParams: [String:String]? = nil) -> URL {
        
        var result = URL(string:baseURL.absoluteString)!
        result.appendPathComponent(servicePath)
        if let query = queryParams {
            let queryParamsString = query.map({ return "\($0)=\($1)" }).joined(separator: "&")
            var components = URLComponents(url: result, resolvingAgainstBaseURL: true)!
            components.query = queryParamsString
            result = components.url!
        }
        return result
    }
    
}

public class JohnLewisAPI: NSObject {

    enum Const {
        
        static let apiKeyQueryParam = "key"
        static let searchQueryParam = "q"
        static let pageSizeQueryParam = "pageSize"
        
        static let endpointSearch = "products/search"
        static let endpointProduct = {(productId:String) in return "products/\(productId)"}
    }
    
    private let config: JohnLewisAPIConfig
    
    init(_ c: JohnLewisAPIConfig) {
        
        config = c
        
    }
    
    public typealias ApiError = (_ error: Error?) -> ()
    
    public typealias GetProductsGridResult = (_ products: [JohnLewisProduct]) -> ()
    public func getProductsGrid(query:String,
                                searchPageSize: Int,
                                result: @escaping GetProductsGridResult,
                                error: @escaping ApiError) {
        
        let result = { (status: NetworkOperationStatus) in
            
            switch status {
            case .successful(let data):
                let products = JohnLewisProduct.parse(productsAsJsonData: data)
                result(products)
            case.failed:
                error(nil)
                return
            }
        }
        
        let queryParams = [Const.searchQueryParam:query,
                           Const.apiKeyQueryParam:config.apiKey,
                           Const.pageSizeQueryParam:String(searchPageSize)]
        let endpointURL = config.createEndpointURL(servicePath: Const.endpointSearch, queryParams: queryParams)
        let getProductsOp = config.networkProvider.createGETOperation(url: endpointURL, operationResult: result)
        config.networkExecutor.execute(operation: getProductsOp)
        
    }

    public typealias GetProductDetailsResult = (_ product: JohnLewisProductDetails) -> ()
    public func getProductDetails(productId:String,
                                  result: @escaping GetProductDetailsResult,
                                  error: @escaping ApiError) {
     
        let result = { (status: NetworkOperationStatus) in
            
            switch status {
            case .successful(let data):
                guard let product = JohnLewisProductDetails.parse(productsAsJsonData: data) else {
                    return
                }
                result(product)
            case.failed:
                error(nil)
                return
            }
        }
        
        let queryParams = [Const.apiKeyQueryParam:config.apiKey]
        let endpointURL = config.createEndpointURL(servicePath: Const.endpointProduct(productId), queryParams: queryParams)
        let getProductsOp = config.networkProvider.createGETOperation(url: endpointURL, operationResult: result)
        config.networkExecutor.execute(operation: getProductsOp)
    }

}
