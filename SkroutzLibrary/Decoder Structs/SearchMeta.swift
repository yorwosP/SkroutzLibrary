//
//  SearchMeta.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/18/19.
//


/*
 "meta": {
    "q": "apple",
    "alternatives": [
 {
   "term": "iphone",
   "important": true
 }

    ],
    "strong_matches": {
      "manufacturer": {
        "id": 356,
        "name": "Apple",
        "image_url": "https://a.scdn.gr/ds/manufacturers/356/20160322115406_ae6f9a87.png"
      }
    },
 */

import Foundation

public struct SearchMeta: Decodable{
    
    public var queryTerm:String
    public var alternatives: [Alternative]?
    public var strongMatches: StrongMatch?
    public var pagination: Meta.Pagination?
    
    
    
    private enum CodingKeys: String, CodingKey{
        
        case queryTerm = "q"
        
        case alternatives
        case strongMatches
        case pagination
    }
    
    
    
    public struct Alternative: Decodable {
        public var term: String
        public var important: Bool
    }
    
    
    
    
    
    
    
    public enum StrongMatch: Decodable{
        
        
        
        public enum StrongMatchTypeCodingError: Error {
            case decoding(String)
        }
        
        public init(from decoder: Decoder) throws {
            self = .empty(nil)
            print("initializing decoder")
            
            
            let values = try decoder.container(keyedBy: CodingKeys.self)
            if let value = try? values.decode(Category.self, forKey: .category) {
                self = .category(value)
                print("found category!")
                //                    TODO: Find a way to assign this to categories
                
                
                
                return
            }
            if let value = try? values.decode(Sku.self, forKey: .sku) {
                self = .sku(value)
                print("found sku!")
                return
            }
            
            if let value = try? values.decode(Manufacturer.self, forKey: .manufacturer) {
                self = .manufacturer(value)
                return
            }
            if let value = try? values.decode(Shop.self, forKey: .sku) {
                self = .shop(value)
                return
            }
            if let value = try? values.decode(String.self, forKey: .empty){
                self = .empty(value)
                return
                
            }else{
                
                //                    return nil (in .empty)
                return
                
            }
        }
        
        case category(Category)
        case sku(Sku)
        case manufacturer(Manufacturer)
        case shop(Shop)
        case empty(String?)
        
        
        
        private enum CodingKeys: String, CodingKey{
            case category
            case sku
            case manufacturer
            case shop
            case empty
        }
        
        
        
        
        
        
    }
    
    
}


