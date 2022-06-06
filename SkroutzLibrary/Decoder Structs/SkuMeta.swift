//
//  File.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/25/19.
//

import Foundation


public struct SkuMeta: Decodable {

    

    public var orderedBy: String?
    public var orderByMethods: [String:String]?
    public var requiresAdultConsent: Bool?
    public var showBlpFilters: Bool?
    public var pagination:Meta.Pagination
    public var personlization: Meta.Personalization?
    public var paymentMethod: Meta.PaymentMethod?
    
    public var appliedFilters:AppliedFilter?
    public var availableFilters:AvailableFilter?
 
    


    

}
