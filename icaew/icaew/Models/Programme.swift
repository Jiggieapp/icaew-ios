//
//  Programme.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

class Programme: MTLModel, MTLJSONSerializing {
    
    private(set) var id = 0
    private(set) var title = ""
    private(set) var descriptions = ""
    private(set) var imageURL = ""
    private(set) var youtubeURL = ""
    
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "title" : "title",
                "descriptions" : "description",
                "imageURL" : "image",
                "youtubeURL" : "youtube"]
    }
    
}
