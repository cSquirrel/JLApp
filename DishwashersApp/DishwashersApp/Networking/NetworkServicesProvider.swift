//
//  NetworkServicesProvider.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

public enum NetworkOperationStatus {
    
    case successful(Data)
    case failed(Error)
    
}

public typealias NetworkOperationBlock = () -> ()

public typealias NetworkOperationResult = (_ result: NetworkOperationStatus) -> Void

public protocol NetworkServicesProvider {

    func createGETOperation(url: URL, operationResult: @escaping NetworkOperationResult) -> NetworkOperationBlock
    
}
