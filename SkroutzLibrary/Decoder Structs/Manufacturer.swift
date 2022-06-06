//
//  Manufacturer.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/13/19.
//

import Foundation
/*
 {
 "manufacturer": {
 "id": 12907,
 "name": "Rapala",
 "image_url": null
 }
 }
 */
public struct Manufacturer:Decodable{
    public var id: Int
    public var name: String
    private var _imageUrl: String?
    
    public var imageUrl: URL?{
        get{
            if let url = _imageUrl{
                return URL(string: url)
            }
            else{
                return nil
            }
            
        }
    }
    
    
    enum CodingKeys:String, CodingKey {
        case id
        case name
        case _imageUrl = "imageUrl"
    }
}
