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
        
        let networkProvider = DefaultServicesProvider()
        let networkExecutor = DefaultNetworkOperationsExecutor(configuration: .default)
        
        // These values are hardcoded here but should be provided from an external configuration file
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
