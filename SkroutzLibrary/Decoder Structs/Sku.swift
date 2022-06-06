//
//  Sku.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/16/19.
//

import Foundation
/*
 {
 "sku": {
 "id": 3443837,
 "ean": "5202888271014",
 "pn": "5202888271014",
 "name": "Hydrating & Restructuring Moisturizing Plus 30+ Cream 50ml",
 "display_name": "Frezyderm Hydrating & Restructuring Moisturizing Plus 30+ Cream 50ml",
 "category_id": 835,
 "first_product_shop_info": null,
 "click_url": null,
 "price_max": 24.27,
 "price_min": 14.71,
 "reviewscore": 4.46667,
 "shop_count": 164,
 "plain_spec_summary": "Δράση: Ενυδάτωση, Τύπος Επιδερμίδας: Ξηρή, Είδος: 24ωρη, Περιοχή: Πρoσώπου",
 "manufacturer_id": 7444,
 "future": false,
 "reviews_count": 30,
 "virtual": false,
 "images": {
 "main": "https://d.scdn.gr/images/sku_main_images/003443/3443837/medium_11707429-orig.jpg",
 "alternatives": [
 "https://a.scdn.gr/images/sku_images/017574/17574475/20170726164235_071f0bdf.jpeg"
 ]
 },
 "web_uri": "https://www.skroutz.gr/s/3443837/Frezyderm-Hydrating-Restructuring-Moisturizing-Plus-30-Cream-50ml.html",
 "comparable": true,
 "reviewable": true,
 "name_source": "display_name",
 "sizes": null,
 "description": "Πλούσια και απαλή ενυδατική κρέμα για το πρόσωπο και το λαιμό, για την καθημερινή περιποίηση της γυναικείας επιδερμίδας. Προσφέρει ενυδάτωση στο ξηρό και μέτρια αφυδατωμένο δέρμα, χάρη στο σύμπλεγμ...",
 "ecommerce_enabled": true,
 "ecommerce_available": true
 }
 }
 */

public struct Sku: Decodable{
    public var id: Int
    //    TODO: convert pn ean to Int maybe?
    public var ean: String?
    public var pn: String?
    public var name: String
    public var displayName: String
    public var categoryId: Int
    //    TODO: find what type is firstProductShopInfo
    //    var firstProductShopInfo: String?
    private var _clickUrl: String?
    public var priceMax: Double
    public var priceMin: Double
    public var reviewScore: Double?
    public var shopCount: Int
    public var plainSpecSummary: String?
    public var manufacturerId: Int
    public var future: Bool?
    public var images: Images?
    private var _webUri: String?
    public var comparable: Bool
    public var reviewable: Bool
    public var nameSource: String
    //    TODO: find what types sizes is
    //    var sizes: ?
    public var description: String?
    public var ecommerceEnabled: Bool
    public var ecommerceAvailable: Bool?
    
    public struct Images:Decodable {
        private var _main: String?
        private var _alternatives: [String]?
        
        enum CodingKeys: String, CodingKey {
            case _main = "main"
            case _alternatives = "alternatives"
            
        }
        
        public var main:URL?{
            get{
                if _main != nil{
                    return URL(string: _main!)
                    
                }else{
                    return nil
                }
            }
        }
        
        public var alternatives: [URL]?{
            get{
                if _alternatives != nil{
                    var alternatives = [URL]()
                    for alternative in _alternatives!{
                        if let url = URL(string:alternative){
                            alternatives.append(url)
                        }
                        
                    }
                    
                    if alternatives.count > 0{
                        return alternatives
                    }else{
                        return nil
                    }
                    
                }else{
                    return nil
                }
            }
        }
        
        
        
    }
    
    
    var clickUrl: URL?{
        get{
            if _clickUrl != nil{
                return URL(string: _clickUrl!)
            }else{
                return nil
            }
            
            
        }
    }
    
    var webUri: URL?{
        get{
            if _webUri != nil{
                
                return URL(string: _webUri!)
                
            }else{
                return nil
            }
            
            
        }
    }
    
    
    enum CodingKeys: String, CodingKey {
        case id
        case ean
        case pn
        case name
        case displayName
        case categoryId
        //  case   firstProductShopInfo
        case priceMax
        case priceMin
        case reviewScore
        case shopCount
        case plainSpecSummary
        case manufacturerId
        case future
        case images
        case comparable
        case reviewable
        case nameSource
        //  case   sizes: ?
        case description
        case ecommerceEnabled
        case ecommerceAvailable
        case _clickUrl = "clickUrl"
        case _webUri = "webUri"
        
        
        
        
        
        
        
        
    }
    
    
    
    
    
    
}

