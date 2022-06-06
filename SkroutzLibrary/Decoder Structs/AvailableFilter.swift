//
//  AvailableFilters.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/25/19.
//
/*
 {    "available_filters": {
       "filters": {
         "553146": 481,
         "553541": 329,
         "553149": 252,

       },
       "manufacturers": {
         "254": 1687,
         "10525": 180,
         "342": 131
       },
       "shops": {
         "846": 287,
         "2182": 239,
         "1993": 193,
         "4309": 182,
     
       },
       "availabilities": [
         {
           "id": 0,
           "label": "Άμεση παραλαβή",
           "count": 2103
         },
         {
           "id": 1,
           "label": "1-3 ημέρες",
           "count": 1512
         }
       ],
       "distances": [
         {
           "id": 2,
           "label": "2km",
           "count": 529
         },
         {
           "id": 5,
           "label": "5km",
           "count": 1205
         },
         {
           "id": 10,
           "label": "10km",
           "count": 1969
         }
       ]
     }
 }
 */



import Foundation
// MARK: - AvailableFilter
public struct AvailableFilter: Decodable {
    
    
    public var filters, manufacturers, shops: [String: Int]?
    public var availabilities: [Availability]?
    public var distances: [Distance]?
   


}


// MARK: - Availability
public struct Availability: Decodable {
    public var id: Int?
    public var label: String?
    public var count: Int?
}
// MARK: - Distance
public struct Distance: Decodable {
    public var id: Int?
    public var label: String?
    public var count: Int?
}

