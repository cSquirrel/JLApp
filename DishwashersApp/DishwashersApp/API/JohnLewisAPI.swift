//
//  JohnLewisAPI.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 22/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

public class JohnLewisAPI: NSObject {

    private let networkProvider: NetworkServicesProvider
    private let networkExecutor: NetworkOperationsExecutor
    
    init(_ network: NetworkServicesProvider, executor: NetworkOperationsExecutor) {
        
        networkProvider = network
        networkExecutor = executor
        
    }
    
    public typealias GetProductsGridResult = (_ products: [JohnLewisProduct]) -> ()
    public func getProductsGrid(result: @escaping GetProductsGridResult) {
        
        let result = { (status: NetworkOperationStatus) in
            
            switch status {
            case .successful(let data):
                let products = JohnLewisProduct.parse(productsAsJsonData: data)
                result(products)
            case.failed:
                return
            }
        }
        let getProductsOp = networkProvider.createGETOperation(url: URL(string:"http://bbc.co.uk/")!, result: result)
        networkExecutor.execute(operation: getProductsOp)
        
    }

}
