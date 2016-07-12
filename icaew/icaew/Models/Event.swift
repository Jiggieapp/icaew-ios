//
//  Event.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/12/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

class Event: MTLModel, MTLJSONSerializing {
    
    private(set) var id = 0
    private(set) var title = ""
    private(set) var subtitle = ""
    private(set) var detail = ""
    private(set) var startDate = ""
    private(set) var countryName = ""
    
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "title" : "title",
                "subtitle" : "description",
                "detail" : "summary",
                "startDate" : "start_date",
                "countryName" : "country_name"]
    }
    
}
