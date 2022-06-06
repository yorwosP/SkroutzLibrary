//
//  SkroutzLibraryDelegate.swift
//  SkroutzLibrary
//
//  Created by Yorwos Pallikaropoulos on 10/24/19.

import Foundation

public protocol SkroutzLibraryDelegate:AnyObject {
//    func didDownloadCategories(_ data: String)
     func authorizationDidSucceed()
     func authorizationDidFail(with: ApiError)
}


