//
//  FilterGroup.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/17/19.
//

import Foundation
/*
 {
   "filter_groups": [
     {
       "id": 48636,
       "name": "Μέγεθος Οθόνης",
       "active": true,
       "category_id": 40,
       "created_at": null,
       "updated_at": "2016-10-04T22:30:54+03:00",
       "hint": "",
       "combined": false,
       "filter_type": 2
     },
     {
       "id": 75300,
       "name": "Μέγεθος Μνήμης RAM",
       "active": true,
       "category_id": 40,
       "created_at": "2014-12-24T19:40:50+02:00",
       "updated_at": "2016-10-04T22:30:54+03:00",
       "hint": "",
       "combined": false,
       "filter_type": 2
     }
   ],
   "meta": {
     "pagination": {
       "total_results": 13,
       "total_pages": 7,
       "page": 1,
       "per": 2
     }
   }
 }
 */


public struct FilterGroup: Decodable {
    
    
    public var id: Int
    public var name: String
    public var active: Bool
    public var categoryId: Int
    public var createdAt: String
    public var updatedAt: String
    public var hint: String
    public var combined: Bool
    public var filterType: FilterType
    
    public enum FilterType: Int,Decodable {
        case price = 0, keyword, spec, syncedSpec, customRange, sizes
        
    }
    
}
