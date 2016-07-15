//
//  Event.swift
//  icaew
//
//  Created by Mohammad Nuruddin Effendi on 7/12/16.
//  Copyright © 2016 Jiggie. All rights reserved.
//

import UIKit
import Mantle

typealias EventsCompletionHandler = (result: APIResult<[Event]>) -> Void

class Event: MTLModel, MTLJSONSerializing {
    
    private(set) var id = 0
    private(set) var title = ""
    private(set) var summary = ""
    private(set) var detail = ""
    private(set) var startDate = ""
    private(set) var countryName = ""
    
    
    static func JSONKeyPathsByPropertyKey() -> [NSObject : AnyObject]! {
        return ["id" : "id",
                "title" : "title",
                "summary" : "summary",
                "detail" : "description",
                "startDate" : "start_date",
                "countryName" : "country_name"]
    }
    
    static func retrieveEvents(countryId id: Int, completionHandler: EventsCompletionHandler) {
        let parameters: [String : AnyObject] = ["country_id" : id]
        if let request = NetworkManager.request(.GET, APIEndpoint.Events, parameters: parameters) {
            request.responseJSON(completionHandler: { (response) in
                let result: APIResult<[Event]>!
                switch response.result {
                case .Success(let json):
                    do {
                        guard let data = json["data"] as? [AnyObject] else {
                            result = .Error(NSError.errorWithJSON(json))
                            break
                        }
                        
                        let events = try MTLJSONAdapter.modelsOfClass(Event.self, fromJSONArray: data) as! [Event]
                        
                        result = .Success(events)
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
