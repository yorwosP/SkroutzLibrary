//
//  Specification.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/13/19.
//

import Foundation


/*
 
 "id": 1792,
 "name": "Τύπος Κινητού",
 "values": [
 
 ],
 "order": 5,
 "unit": ""
 */

public struct Specification:Decodable{
    
    public var id: Int
    public var name: String
    public var values : [String]?
    public var order: Int
    public var unit: String?
    
    
    
}
