//
//  SkroutzError.swift
//  SkroutzLibrary
//  used to decode errors received from Skroutz API
//
//  Created by Yorwos Pallikaropoulos on 11/21/19.
//  Copyright © 2019 Yorwos Pallikaropoulos. All rights reserved.
//

import Foundation

public struct SkroutzError: Decodable {
    public var code: String?
    private var _messages: [String]?
    
    //    I don't think Skroutz API returns more than one message
    //    Gonna use one anyway
    public var message: String?{
        return _messages?.first
        
    }
    
    
    
    enum CodingKeys: String, CodingKey {
        case code
        case _messages = "messages"
    }
}
