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
    
    let baseURL = "http://hungry.biancabaier.de/json/category.php"
    /*let baseURL = "http://hungry.biancabaier.de/json/locations.php?category=abc"
    for result in json["locations"].arrayValue {
    let id = result["id"].stringValue
    let categories = result["categories"].arrayValue
    print("ID: " + id + "Categories:")
    print(categories[0]) */
    
    func getCategories(onCompletion: (JSON) ->Void){
        makeHTTPGetRequest(baseURL, onCompletion: {json, err -> Void in onCompletion(json)})
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