//
//  Meta.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/12/19.
//

import Foundation

public struct Meta:Decodable {
    
    
    public var requiresAdultConsent: Bool?
    public var showBlpFilters: Bool?
    
    public var pagination: Pagination?
    
    
    
    public struct Pagination:Decodable{
        var totalResults:Int?
        var totalPages:Int?
        var page:Int?
        var per:Int?
        
    }
    
    
    public var personalization: Personalization?
    
    public struct Personalization:Decodable {
        public var location: Location?
        
        public struct Location:Decodable {
            
            public var addressId: Int?
            public var label: String?
            private var _lat: String?
            private var _lng: String?
            public var type: String?
            public var countryCode: String?
            
            enum CodingKeys:String, CodingKey {
                case addressId
                case label
                case _lat = "lat"
                case _lng = "lng"
                case type
                case countryCode
            }
            
            
            public var lat:Double?{
                get{
                    if let lat = _lat{
                        return Double(lat)
                    }else{
                        return nil
                    }
                }
            }
            
            public var lng: Double?{
                get{
                    if let lng = _lng{
                        return Double(lng)
                    }else{
                        return nil
                    }
                }
            }
        }
    }
    public var paymentMethod:PaymentMethod?
    
    public struct PaymentMethod:Decodable {
        public var type: String
    }
    
    public var foodLocation:FoodLocation?
    
    public struct FoodLocation: Decodable{
        
        public var addressId:Int?
        public var streetName:String?
        public var steetNumber:Int?
        public var zip:String?
        public var city:String?
        private var _lat:String?
        private var _lng:String?
        
        enum CodingKeys:String, CodingKey {
            case addressId
            case streetName
            case steetNumber
            case zip
            case city
            case _lat = "lat"
            case _lng = "lng"
        }
        
        public var lat:Double?{
            get{
                if let lat = _lat{
                    return Double(lat)
                }else{
                    return nil
                }
            }
        }
        
        public var lng: Double?{
            get{
                if let lng = _lng{
                    return Double(lng)
                }else{
                    return nil
                }
            }
        }
    }
    public var shopRatingBreakdown: ShopRatingBreakdown?
    
    public struct ShopRatingBreakdown: Decodable{
        public var impression: String
        public var percentage: Double
        public var count: Int
    }
}




/*
 "food_location":{
 "address_id":null,
 "street_name":null,
 "street_number":null,
 "zip":null,
 "city":null,
 "lat":null,
 "lng":null
 */









