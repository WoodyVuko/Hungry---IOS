//
//  JSONData.swift
//  Hungry
//
//  Created by Goran Vukovic on 17.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import UIKit

class FriendClass
{
    private var id : String = ""
    private var images : String = ""
    private var description : String = ""
    private var timeStamp : String = ""
    private var container: NSMutableArray = NSMutableArray()
    
    func loadIn(id : String, images : String, description : String, time: String)
    {
        self.description = description
        self.id = id;
        self.images = images

    }
    
    func getContainer(i : Int) -> AnyObject
    {
        return self.container.objectAtIndex(i)
    }
    
    func getContainerLength() -> Int
    {
        return self.container.count
    }
    
    
    func getID() -> String
    {
        return self.id
    }
    
    
    func getImages() -> String
    {
        return self.images
    }
    
    func getDescription() -> String
    {
        return self.description
    }
    
}
