//
//  JSONServicesProvider.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class DefaultServicesProvider: NetworkServicesProvider {

    func createGETOperation(url: URL, operationResult result: @escaping NetworkOperationResult) -> NetworkOperationBlock {
        
        return { (session: URLSession) in
            
            let dataTask = session.dataTask(with: url, completionHandler: {
                (responseData: Data?, urlResponse: URLResponse?, responseError: Error?) in
                
                if let rData = responseData {
                    DispatchQueue.global(qos:.default).async {result( .successful(rData) )}
                } else {
                    DispatchQueue.global(qos:.default).async { result( .failed(responseError) )}
                }
                
            })
            dataTask.resume()
        }
    }
    
    func fetchImage(url: URL, completion: @escaping (UIImage?) -> Void) -> NetworkOperationBlock {
        
        return { (session: URLSession) in
            
            let dataTask = session.dataTask(with: url, completionHandler: {
                (responseData: Data?, urlResponse: URLResponse?, responseError: Error?) in
                
                if let rData = responseData {
                    let image = UIImage(data: rData)
                    DispatchQueue.global(qos:.default).async { completion(image) }
                } else {
                    DispatchQueue.global(qos:.default).async { completion(nil) }
                }
                
            })
            dataTask.resume()
        }
    }
}
