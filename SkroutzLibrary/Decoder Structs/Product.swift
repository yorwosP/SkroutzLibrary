//
//  Product.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/12/19.
//


import Foundation
  
//     "id": 29878439,
//     "name": "Apple iPhone 5S Space Grey 16 GB EU ( ✔ΔΩΡΟ ΘΗΚΗ + ✔TEMPERED GLASS )",
//     "sku_id": 3783654,
//     "shop_id": 4102,
//     "category_id": 40,
//     "availability": "Παράδοση 1 έως 3 ημέρες",
//     "click_url": "https://www.skroutz.gr/products/show/29878439?client_id=XIbz2_n2p94JTskRpHu9wQ%3D%3D&from=api",
//     "shop_uid": "548",
//     "expenses": null,
//     "web_uri": "http://skroutz.gr:3000/products/show/29878439",
//     "sizes": [
//
//     ],
//     "blp": {
//       "shipping_cost": 4.41,
//       "payment_method_cost": 3.5,
//       "final_price": 297.81
//     },
//     "price": 289.9,
//     "immediate_pickup": false
//   }



public struct Product:Decodable {

    public var id: Int
    public var name: String
    public var skuId: Int
    public var shopId: Int
    public var categoryId: Int
    public var availability: String
    private var _clickUrl: String?
    public var shopUid: String
//    var expenses: [Any]
    private var _webUri: String?
    public var sizes: [String]?
    public var price: Double
    public var immediatePickup: Bool
    public var blp: Blp?
    
    public struct Blp:Decodable {
        public var shippingCost: Double?
        public var paymentMethodCost: Double?
        public var finalPrice: Double
    }

    public var clickUrl: URL?{
        get{
            if _clickUrl != nil{
            return URL(string: _clickUrl!)
            }else{
                return nil
            }
            

        }
    }

    public var webUri: URL?{
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
        case name
        case skuId
        case shopId
        case categoryId
        case availability
        case _clickUrl = "clickUrl"
        case shopUid
//        case expenses
        case _webUri = "webUri"
        case sizes
        case price
        case immediatePickup
        case blp

    }



}
