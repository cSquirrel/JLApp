//
//  NetworkOperationsExecutor.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

public protocol NetworkOperationsExecutor {
    
    func execute(operation: NetworkOperationBlock)
    
}

public func CreateHttpExecutor() -> NetworkOperationsExecutor {
    return HTTPNetworkOperationsExecutor()
}

fileprivate class HTTPNetworkOperationsExecutor: NetworkOperationsExecutor {

    public func execute(operation: NetworkOperationBlock) {
        operation()
    }
    
}
