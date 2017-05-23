//
//  MockNetworkOperationsExecutor.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit
@testable import DishwashersApp

class MockNetworkOperationsExecutor: NetworkOperationsExecutor {

    func execute(operation: NetworkOperationBlock) {
        operation()
    }
}
