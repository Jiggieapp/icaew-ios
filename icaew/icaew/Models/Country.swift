//
//  Country.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/12/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

typealias CountryCompletionHandler = (result: APIResult<[Country]>) -> Void

class Country: MTLModel, MTLJSONSerializing {
    
    private(set) var id = 0
    private(set) var code = ""
    private(set) var name = ""
    private(set) var imageURL = ""
    
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "code" : "code",
                "name" : "name",
                "imageURL" : "image"]
    }
    
    static func retrieveCountries(completionHandler: CountryCompletionHandler) {
        if let request = NetworkManager.request(.GET, APIEndpoint.Country) {
            request.responseJSON(completionHandler: { (response) in
                let result: APIResult<[Country]>!
                switch response.result {
                case .Success(let json):
                    do {
                        guard let data = json["data"] as? [AnyObject] else {
                            result = .Error(NSError.errorWithJSON(json))
                            break
                        }
                        
                        let countries = try MTLJSONAdapter.modelsOfClass(Country.self, fromJSONArray: data) as! [Country]
                        
                        result = .Success(countries)
                    } catch (let error) {
                        result = .Error(error as NSError)
                    }
                    
                case .Failure(let error):
                    result = .Error(error)
                }
                
                completionHandler(result: result)
            })
        }
    }
}
