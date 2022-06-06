//
//  HttpResponseCode.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 11/20/19.
//
//

import Foundation

    

public enum HttpResponseCode: Int {
    
    case ok = 200
    case created

    case badRequest = 400
    case unauthorized = 401
    case notFound = 404
    case unprocessableEntity = 422
    case internalServerError = 500
    case notImplemented = 501
    case unknown = 9999
    
    var description: String{
        switch self {
        case .ok:
            return "OK"
        case .created:
            return "Created"
        
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .notFound:
            return "Not Found"
        case .unprocessableEntity:
            return "Unprocessable Entity"
        case .internalServerError:
            return "Internal Server Error"
        case .notImplemented:
            return "Not Implemented"
        case .unknown :
            return "Unknown"
        }
    }
    
    
    
}


