//
//  Category.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/3/19.
//

import Foundation


// {
//   "category": {
//     "id": 88,
//     "name": "SSD Σκληροί Δίσκοι",
//     "children_count": 0,
//     "image_url": "http://d.scdn.gr/ds/categories/88/20171113120930_4a77e901.jpeg",
//     "parent_id": 1716,
//     "fashion": false,
//     "layout_mode": "list",
//     "web_uri": "http://skroutz.gr:3000/c/88/ssd-sklhroi-diskoi.html",
//     "code": "esoterikoi-sklhroi-diskoi",
//     "family_id": 1269,
//     "show_manufacturers_filter": true,
//     "adult": false,
//     "onclick_behaviour": "onclick_to_sku_page",
//     "show_spec_summary": false,
//     "unit_price_label": "GB",
//     "reviewable": true,
//     "comparable": true,
//     "path": "76,1269,22,27,46,1716,88",
//     "show_specifications": true,
//     "manufacturer_title": "Κατασκευαστές"
//   }
// }

public struct Category:Decodable{
    
    
    
    
    public var id: Int
    public var name: String
    public var childrenCount: Int
    private var _imageUrl: String
    public var parentId: Int
    public var fashion: Bool
    //    TODO: make layoutMode an enumeration maybe?
    public var layoutMode: String
    private var _webUri: String
    public var code: String
    public var familyId: Int?
    public var showManufacturersFilter: Bool?
    public var adult: Bool?
    public var onClickBehaviour: String?
    public var showSpecSummary: Bool?
    //    TODO: make unitPriceLabel an enumeration maybe?
    public var unitPriceLabel: String?
    public var reviewable: Bool?
    public var comparable: Bool?
    //    TODO: make path a linked list maybe?
    public var path: String
    public var showSpecifications: Bool?
    public var manufacturerTitle: String
    public var matchCount: Int?
    
    public var imageUrl: URL?{
        get{
            return URL(string: _imageUrl)
            
        }
    }
    public var webUri: URL?{
        get{
            return URL(string: _webUri)
        }
    }
    
    enum CodingKeys:String, CodingKey {
        
        case id
        case name
        case childrenCount
        case _imageUrl = "imageUrl"
        case parentId
        case fashion
        case layoutMode
        case _webUri = "webUri"
        case code
        case familyId
        case showManufacturersFilter
        case adult
        case onClickBehaviour = "onclickBehaviour"
        case showSpecSummary
        case unitPriceLabel
        case reviewable
        case comparable
        case path
        case showSpecifications
        case manufacturerTitle
        case matchCount
    }
    //
    
    
    
    
    
}
    
    


    
    

    
    
    
    

