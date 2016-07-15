//
//  APIHelper.swift
//  Jiggie
//
//  Created by Mohammad Nuruddin Effendi on 6/3/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import Foundation

/**
 Used to represent whether a request was successful or encountered an error.
 
 - Success: The request and all post processing operations were successful resulting in
 the native model serialization of the provided associated value.
 - Error  : The request encountered an error due to an error on the server,
 fail when serialize the model, or unknown error.
 */
public enum APIResult<Value> {
    case Success(Value)
    case Error(NSError)
}


/// API endpoint constants.
public struct APIEndpoint {
    
    static let Programme = "program/"
    static let LikeProgramme = "program_like/"
    static let Country = "country/"
    static let Events = "event/"
    static let Contact = "contact/"
    static let University = "university/"
}
