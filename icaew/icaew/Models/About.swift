//
//  About.swift
//  icaew
//
//  Created by Setiady Wiguna on 7/1/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import Cocoa
import Mantle

class About: MTLModel, MTLJSONSerializing {
    var title: String
    var image: String
    var description: String
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]!
    {
        return ["title" : "title",
                "image" : "image",
                "description" : "description"]
    }
    
}
