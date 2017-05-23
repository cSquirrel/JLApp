//
//  TestUtils.swift
//  DishwashersApp
//
//  Created by Marcin Maciukiewicz on 23/05/2017.
//  Copyright © 2017 Blue Pocket Limited. All rights reserved.
//

import UIKit

class TestUtils: NSObject {

    static func loadJSONData(fileName: String) -> Data? {
        let bundle = Bundle(for: TestUtils.self)
        guard
            let jsonFilePath = bundle.url(forResource: fileName, withExtension: "json"),
            let jsonData = try? Data(contentsOf: jsonFilePath) else {
                return nil
        }
        
        return jsonData
    }
    
    static func loadJSONDictionary(fileName: String) -> [String:Any]? {
        
        guard let jsonData = loadJSONData(fileName: fileName),
            let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []),
            let result = jsonObject as? [String:Any] else {
            return nil
        }
        
        return result
    }
    
}
