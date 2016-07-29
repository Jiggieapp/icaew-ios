//
//  Contact.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

typealias ContactDetailCompletionHandler = (result: APIResult<[Contact]>) -> Void

class Contact: MTLModel, MTLJSONSerializing {

    private(set) var id = 0
    private(set) var imageURL = ""
    private(set) var countryName = ""
    private(set) var address = ""
    private(set) var phoneNumber = ""
    private(set) var emailAddress = ""
    private(set) var facebookAddress = ""
    private(set) var websiteAddress = ""
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "imageURL" : "image",
                "countryName" : "country_name",
                "address" : "address",
                "phoneNumber" : "telp",
                "emailAddress" : "email",
                "facebookAddress" : "facebook",
                "websiteAddress" : "website"]
    }
    
    static func retrieveContactDetail(countryId id: Int, completionHandler: ContactDetailCompletionHandler) {
        let parameters: [String : AnyObject] = ["country_id" : id]
        if let request = NetworkManager.request(.GET, APIEndpoint.Contact, parameters: parameters) {
            request.responseJSON(completionHandler: { (response) in
                let result: APIResult<[Contact]>!
                switch response.result {
                case .Success(let json):
                    do {
                        guard let data = json["data"] as? [AnyObject] else {
                            result = .Error(NSError.errorWithJSON(json))
                            break
                        }
                        
                        let contacts = try MTLJSONAdapter.modelsOfClass(Contact.self, fromJSONArray: data) as! [Contact]
                        
                        result = .Success(contacts)
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
