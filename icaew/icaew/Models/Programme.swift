//
//  Programme.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/11/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

typealias ProgrammesCompletionHandler = (result: APIResult<[Programme]>) -> Void

class Programme: MTLModel, MTLJSONSerializing {
    
    private(set) var id = 0
    private(set) var title = ""
    private(set) var initial = ""
    private(set) var detail = ""
    private(set) var imageURL = ""
    private(set) var youtubeURL = ""
    private(set) var isBanner = false
    
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "title" : "title",
                "initial" : "initial",
                "detail" : "description",
                "imageURL" : "image",
                "youtubeURL" : "youtube",
                "isBanner" : "is_banner"]
    }
    
    static func retrieveProgrammes(completionHandler: ProgrammesCompletionHandler) {
        if let request = NetworkManager.request(.GET, APIEndpoint.Programme) {
            request.responseJSON(completionHandler: { (response) in
                let result: APIResult<[Programme]>!
                switch response.result {
                case .Success(let json):
                    do {
                        guard let data = json["data"] as? [AnyObject] else {
                            result = .Error(NSError.errorWithJSON(json))
                            break
                        }
                        
                        let programmes = try MTLJSONAdapter.modelsOfClass(Programme.self, fromJSONArray: data) as! [Programme]
                        
                        result = .Success(programmes)
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
