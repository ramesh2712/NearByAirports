//
//  DataGenerator.swift
//  NearestAirports
//
//  Created by ramesh on 14/12/19.
//  Copyright © 2019 Ramesh. All rights reserved.
//

import Foundation

class DataGenerator {
    
    static func readJSONData() -> [[String:Any]] {
        
      var json : [[String:Any]]?
     
      if let path = Bundle.main.path(forResource: "airports", ofType: "json") {
         do {
             let fileUrl = URL(fileURLWithPath: path)
             let data = try Data(contentsOf: fileUrl, options: .mappedIfSafe)
             let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
             if let jsonResult = jsonResult as? [[String:Any]] {
                     json = jsonResult
                 }
              } catch {
                   // handle error
              }
        }
      return json!
    }
}
