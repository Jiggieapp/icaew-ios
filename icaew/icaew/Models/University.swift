//
//  University.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/12/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

typealias UniversityCompletionHandler = (result: APIResult<University>) -> Void

class University: MTLModel, MTLJSONSerializing {
    
    private(set) var id = 0
    private(set) var countryID = 0
    private(set) var name = ""
    private(set) var imageURL = ""
    private(set) var emailAddress = ""
    private(set) var phoneNumber = ""
    private(set) var address = ""
    private(set) var countryName = ""
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "countryID" : "country_id",
                "name" : "name",
                "imageURL" : "image",
                "emailAddress" : "email",
                "phoneNumber" : "phone",
                "address" : "address",
                "countryName" : "country_name"]
    }
    
    static func retrieveUniversityDetail(countryID: Int , completionHandler: UniversityCompletionHandler) {
        let params: [String : AnyObject] = ["country_id": countryID]
        
        if let request = NetworkManager.request(.GET, APIEndpoint.University, parameters: params) {
            request.responseJSON(completionHandler: { (response) in
                let result: APIResult<University>!
                switch response.result {
                case .Success(let json):
                    do {
                        guard let data = json["data"] as? [String : AnyObject] else {
                            result = .Error(NSError.errorWithJSON(json))
                            break
                        }
                        
                        let university = try MTLJSONAdapter.modelOfClass(University.self, fromJSONDictionary: data) as! University
                        
                        result = .Success(university)
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
