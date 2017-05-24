//
//  NetworkOperationsExecutor.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

public protocol NetworkOperationsExecutor {
    
    func execute(operation: @escaping NetworkOperationBlock)
    
}

public func CreateHttpExecutor(configuration: URLSessionConfiguration) -> NetworkOperationsExecutor {
    return HTTPNetworkOperationsExecutor(configuration: configuration)
}

fileprivate class HTTPNetworkOperationsExecutor: NetworkOperationsExecutor {

    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        
        session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    }
    
    public func execute(operation: @escaping NetworkOperationBlock) {
        
        DispatchQueue.main.async { [unowned self] in operation(self.session) }
        
    }
    
}
