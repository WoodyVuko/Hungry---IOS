//
//  RestAPIManager.swift
//  Json Test
//
//  Created by Goran Vukovic on 14.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

//  RestApiManager.swift


import Foundation

typealias ServiceResponse = (JSON, NSError?) -> Void
class RestApiManager: NSObject{
    
    static let sharedInstance = RestApiManager()
    
    let baseURL = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/search/category?&jsonace=414"
    var localURL = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/search?"
    
    func getCategories(onCompletion: (JSON) ->Void)
    {
        makeHTTPGetRequest(baseURL, onCompletion: {json, err -> Void in onCompletion(json)})
    }
    
    func getLocals(onCompletion: (JSON) ->Void)
    {
        makeHTTPGetRequest(localURL, onCompletion: {json, err -> Void in onCompletion(json)})
    }
    
    
    func makeHTTPGetRequest(path: String, onCompletion: ServiceResponse){
        let request = NSMutableURLRequest(URL: NSURL(string: path)!)
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error in
            
            let json:JSON = JSON(data: data!)
            onCompletion(json, error)
        })
        task!.resume()

    }
}