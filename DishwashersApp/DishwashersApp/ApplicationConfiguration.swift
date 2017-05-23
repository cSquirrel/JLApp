//
//  ApplicationConfiguration.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class ApplicationConfiguration: NSObject {

    private(set) var apiAccess: JohnLewisAPI!
    
    override func awakeFromNib() {
        createApiAccess()
    }
    
    fileprivate func createApiAccess() {
        
        let networkProvider = MockDataServicesProvider()
        let networkExecutor = CreateHttpExecutor()
        let baseURL = URL(string:"https://api.johnlewis.com/v1")!
        let apiKey = "Wu1Xqn3vNrd1p7hqkvB6hEu0G9OrsYGb"
        let apiConfig = JohnLewisAPIConfig(networkProvider: networkProvider,
                                           networkExecutor: networkExecutor,
                                           baseURL: baseURL,
                                           apiKey:
            apiKey)
        apiAccess = JohnLewisAPI(apiConfig)
    }
}


fileprivate class MockDataServicesProvider: NetworkServicesProvider {
    
    static let createProductJsonString = { (productId: String) -> String in
        return "{\"productId\": \"\(productId)\",\"title\": \"Product \(productId)\",\"price\": {\"now\": \"9.99 \(productId)\"},\"image\": \"http://test.server.com/image_\(productId).png\"}"
    }
    
    static let mockJsonString: String = "{\"products\": [\(((1...20)).map({createProductJsonString("pid\($0)")}).joined(separator: ","))]}"

    func createGETOperation(url: URL, result: @escaping NetworkOperationResult) -> NetworkOperationBlock {
        
        return { result( .successful(MockDataServicesProvider.mockJsonString.data(using: .utf8)!) ) }
    }
}
