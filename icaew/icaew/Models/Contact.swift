//
//  Contact.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

class Contact: MTLModel, MTLJSONSerializing {

    private(set) var id = 0
    private(set) var countryName = ""
    private(set) var address = ""
    private(set) var phoneNumber = ""
    private(set) var emailAddress = ""
    private(set) var facebookAddress = ""
    private(set) var websiteAddress = ""
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "countryName" : "country_name",
                "address" : "address",
                "phoneNumber" : "telp",
                "emailAddress" : "email",
                "facebookAddress" : "facebook",
                "websiteAddress" : "website"]
    }
    
}
