//
//  ApiError.swift
//  SkroutzLibrary
//
//  placeholder for type of error (api, parsing, network etc)
//  Created by Yorwos Pallikaropoulos on 11/21/19.


import Foundation

public enum ApiError: Error {
    
    case networkError(errorCode: HttpResponseCode, skroutzError: SkroutzError?, additionalMessage:String = "")
    case genericError(message:String)
    case parsingError
    
    
    private var errorCode: String{
        
        switch self {
        case let .networkError(errorCode, skroutzError, _):
            if let skroutzCode = skroutzError?.code{

//                if skroutz api provided an error code give that back. else give the http error (e.g 404)
                return skroutzCode
            }else{
                print("NO code from API")
                
                return errorCode.description
                
            }
            
        default:
            return "Unknown"
        }
        
    }
    
    
    
    var message: String{
        switch self {
        case let .networkError(_, skroutzError, additonalMessage):
            if let message = skroutzError?.message{
                
                return message
            }else{
                
                return additonalMessage
            }
        case let .genericError(message):
            return message
        case  .parsingError:
            return ""
            
       }
        
    }
    

}


extension ApiError: LocalizedError{
    public var errorDescription: String? {
        return(message)
    }
    
    public var failureReason: String?{
        switch self{
        case  .networkError:
            return "Network error (\(errorCode))"
        case .genericError(_):
            return "Application error"
        case .parsingError:
            return "Parsing error"
            
            
            
        }
        
        
    }
    
}

    



