//
//  Book.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/30/19.
//

import Foundation

public struct Book: Decodable {
    public var id: Int?
    public var name: String?
    public  var mainAuthorID: Int?
    public  var mainAuthor: String?
    public  var images: Images?
    public  var priceMin, priceMax: Double?
    public  var shopCount, reviewscore, reviewsCount: Int?
    //  public  var firstProductShopInfo: String?
    private var _webUri: String?
    public  var reviewable, ecommerceEnabled, ecommerceAvailable, isBook: Bool?
    
    public struct Images: Decodable {
        public  var main: String?
    }
    
    public  var webUri: URL?{
        
        get{
            if let url = _webUri{
                return URL(string: url)
            }
            else{
                return nil
            }
            
        }
    }
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case mainAuthorID
        case mainAuthor
        case images
        case priceMin, priceMax
        case shopCount, reviewscore, reviewsCount
        case _webUri = "webUri"
        case reviewable, ecommerceEnabled, ecommerceAvailable, isBook
    }
    
    
}


