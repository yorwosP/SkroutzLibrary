//
//  History.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/30/19.
//

import Foundation


public struct History: Decodable{
    public var average: [Average]?
    public var lowest: [Lowest]?
    
    public struct Average: Decodable {
        var date: String?
        var price: Double?
    }


    public struct Lowest: Decodable {
        var date: String?
        var price: Double?
        var shopName: String?
    }

}



