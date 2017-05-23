//
//  JSONServicesProvider.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class JSONServicesProvider: NetworkServicesProvider {

    func createGETOperation(url: URL, result: @escaping NetworkOperationResult) -> NetworkOperationBlock {
        
        return { result( .successful(Data()) ) }
    }
}
