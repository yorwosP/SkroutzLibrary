//
//  Token.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/10/2019.
//

import Foundation


struct TokenData: Codable {
    var accessToken: String
    var tokenType: String
    var expiresIn: Int
    var expiresOn: Date{
        get{
            
            return Date(timeIntervalSinceNow: Double(expiresIn))
        }
    }
    // is valid until expiration date has passed
    var isValid: Bool{
        get{
            return Date() < expiresOn
        }
    }
    
    
  
   
}
