//
//  AutoComplete.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/19/19.
//

import Foundation

/*
[{
    "k": "iphone",
    "i": 1
}, {
    "k": "iphone 8",
    "i": 1
}, {
    "k": "iphone xr",
    "i": 1
}, {
    "k": "iphone 7",
    "i": 1
}]


 
 [{
     "k": "ααα μπαταριες",
     "i": 3
 }, {
     "k": "ααα μπαταριες",
     "i": 3,
     "d": {
         "u": "/c/2658/alkalikes-mpataries.html",
         "id": 2658,
         "n": "Αλκαλικές Μπαταρίες"
     }
 }, {
     "k": "amazfit",
     "i": 0
 }, {
     "k": "αμανικα μπουφαν ανδρικα",
     "i": 0
 }, {
     "k": "ανατομικα παπουτσια γυναικεια",
     "i": 0
 }, {
     "k": "αναπτηρες",
     "i": 0
 }, {
     "k": "αμανικο μπουφαν",
     "i": 0
 }, {
     "k": "αμανικα μπουφαν γυναικεια",
     "i": 0
 }, {
     "k": "ανατομικα μποτακια γυναικεια",
     "i": 0
 }, {
     "k": "ανακλινδρα",
     "i": 0
 }, {
     "k": "αναρτησεις ποδηλατου",
     "i": 0
 }, {
     "k": "αναλογιο μουσικης",
     "i": 0
 }]
 
 
 
*/
public struct Autocomplete: Decodable{
    public var term: String
    public var numberOfMatchedCharacters: Int
    public var categoryInfo: CategoryInfo?
    
    
    enum CodingKeys: String, CodingKey {
        
        case term = "k"
        case numberOfMatchedCharacters = "i"
        case categoryInfo = "d"
    

    }
    
    
    
    
    
    public struct CategoryInfo: Decodable {
        var _url: String?
        var id: Int
        var name: String
        
        var url: URL?{
            get{
                if let url = _url{
                    return URL(string: url)
                }
                else{
                    return nil
                }
                
            }
        }
        enum CodingKeys: String, CodingKey {
            
            case _url = "u"
            case id
            case name = "n"
        

        }
            
    }
    
    
}
