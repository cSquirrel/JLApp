//
//  ApplicationConfiguration.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

/**
 * The reason why images provider does not belong to the networking layer is
 * that although images can be provided through network layer, they may also be provided
 * in any other way ( cache, local file ).
 */
typealias ImagesProvider = (_ url: URL, _ completion: @escaping (UIImage?) -> Void) -> ()

class ApplicationConfiguration: NSObject {
    
    private(set) var apiAccess: JohnLewisAPI!
    private(set) var imagesProvider: ImagesProvider!
    
    override func awakeFromNib() {
        createApiAccess()
    }
    
    fileprivate func createApiAccess() {
        
        let networkProvider = JSONServicesProvider()
        let networkExecutor = CreateHttpExecutor(configuration: .default)
        let baseURL = URL(string:"https://api.johnlewis.com/v1")!
        let apiKey = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
        let apiConfig = JohnLewisAPIConfig(networkProvider: networkProvider,
                                           networkExecutor: networkExecutor,
                                           baseURL: baseURL,
                                           apiKey: apiKey)
        apiAccess = JohnLewisAPI(apiConfig)
        
        imagesProvider = { (url: URL, completion: @escaping (UIImage?) -> Void) -> () in
            let fetchImageOperation = networkProvider.fetchImage(url: url, completion: completion)
            networkExecutor.execute(operation: fetchImageOperation)
        }
    }
}


fileprivate class MockDataServicesProvider: NetworkServicesProvider {
    
    static let createProductJsonString = { (productId: String) -> String in
        return "{\"productId\": \"\(productId)\",\"title\": \"Product \(productId)\",\"price\": {\"now\": \"9.99 \(productId)\"},\"image\": \"http://test.server.com/image_\(productId).png\"}"
    }
    
    static let mockJsonString: String = "{\"products\": [\(((1...20)).map({createProductJsonString("pid\($0)")}).joined(separator: ","))]}"
    
    static let mockProductDetailsJsonString = "{\"productId\":\"ProductId\",\"title\":\"Mock Product Title\",\"price\":{\"now\":\"549.00\"},\"code\":\"ProductCode\",\"displaySpecialOffer\":\"Extra 3 years guarantee\",\"additionalServices\":{\"includedServices\":[\"2 year guarantee included\"]},\"media\":{\"images\":{\"urls\":[\"http://test.server/image1.png\",\"http://test.server/image2.png\"]}},\"details\":{\"productInformation\":\"Product Information\"},\"features\":[{\"attributes\":[{\"name\":\"Dimensions\",\"value\":\"H84.5 x W60 x D60cm\"},{\"name\":\"Number of Programs\",\"value\":\"6\"}]}]}"

    func createGETOperation(url: URL, operationResult: @escaping NetworkOperationResult) -> NetworkOperationBlock {
        
        let result:NetworkOperationBlock
        if url.path.hasSuffix("products/search") {
            result = { _ in operationResult( .successful(MockDataServicesProvider.mockJsonString.data(using: .utf8)!) ) }
        } else {
            result = { _ in operationResult( .successful(MockDataServicesProvider.mockProductDetailsJsonString.data(using: .utf8)!) ) }
        }
        
        return result
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) -> NetworkOperationBlock {
        return { _ in completion(UIImage(named:"image_placeholder"))}
    }
}
