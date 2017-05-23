//
//  MockNetworkServicesProvider.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit
@testable import DishwashersApp

class MockNetworkServicesProvider: NetworkServicesProvider {

    var mockDataToReturn = Data()
    
    func createGETOperation(url: URL, result: @escaping NetworkOperationResult) -> NetworkOperationBlock {
        
        return { [unowned self] in result( .successful(self.mockDataToReturn) ) }
    }
    
}
