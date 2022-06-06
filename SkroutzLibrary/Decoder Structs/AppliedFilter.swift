//
//  AppliedFilter.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/25/19.
//

import Foundation


/*
 {
 "applied_filters": {
     "filters": [],
     "manufacturers": [
         28,
         2
     ],
     "shops": [],
     "filters_extra": [],
     "manufacturers_extra": [
         {
             "id": 28,
             "name": "Samsung"
         },
         {
             "id": 2,
             "name": "Sony"
         }
     ],
     "shops_extra": [],
     "custom_range": []
 }
 */

public struct AppliedFilter:Decodable {
    public var filtersIds: [Int]?
    public var manufacturersIds: [Int]?
    public var shopsIds: [Int]?
    public var filtersExtra, shopsExtra, manufacturesExtra: [Extra]?
//    custom range (no idea what this is) 
    
    enum codingKeys:String, CodingKey {
        case filtersIds = "filters"
        case manufacturersIds = "manufacturers"
        case shopsIds = "shops"
        case filtersExtra, shopsExtra, manufacturesExtra
    }
}


public struct Extra:Decodable {
    var id: Int?
    var name: String?
}
