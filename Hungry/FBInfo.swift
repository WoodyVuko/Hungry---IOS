//
//  JSONData.swift
//  Hungry
//
//  Created by Goran Vukovic on 17.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import UIKit

class FriendInfo
{
    private var id : String = ""
    private var name : String = ""
    
    func loadIn(id : String, name:  String)
    {
        self.name = name
        self.id = id;
    }
    
    func getID() -> String
    {
        return self.id
    }
    
    
    func getName() -> String
    {
        return self.name
    }
    

    
}
