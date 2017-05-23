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
                let products = JohnLewisAPI.parse(productsAsJsonData: data)
                result(products)
            case.failed:
                return
            }
        }
        let getProductsOp = networkProvider.createGETOperation(url: URL(string:"http://bbc.co.uk/")!, result: result)
        networkExecutor.execute(operation: getProductsOp)
        
    }
    
    static func parse(productsAsJsonData: Data) -> [JohnLewisProduct] {
        
        let result = [JohnLewisProduct(productId:"product_1",
                                 price: "9.99",
                                 title: "Product #1",
                                 imageURL: URL(string: "http://test.server.com/image1.png")!),
                JohnLewisProduct(productId:"product_2",
                                 price: "9.99",
                                 title: "Product #3",
                                 imageURL: URL(string: "http://test.server.com/image2.png")!),
                JohnLewisProduct(productId:"product_3",
                                 price: "9.99",
                                 title: "Product #3",
                                 imageURL: URL(string: "http://test.server.com/image3.png")!)]
        
        return result
    }
}
