//
//  JSONData.swift
//  Hungry
//
//  Created by Goran Vukovic on 17.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

class JSONData
{
    private var id : String = ""
    private var title : String = ""
    private var address : String = ""
    private var lat : Double = 0.0
    private var lon : Double = 0.0
    private var categorie : String = ""
    private var rating : Float = 0.0
    private var open : Bool = false
    private var opening_hours : String = ""
    private var images : String = ""
    private var hearts : Int = 0
    private var distance : Float = 0.0
    private var description : String = ""
    private var meter : Int = 0
    
    func loadIn(id : String, title : String, address : String, lat : Double, lon : Double, categorie : String, rating : Float, images : String, meter : Int)
    {
        self.id = id;
        self.title = title
        self.address = address
        self.lat = lat
        self.lon = lon
        self.categorie = categorie
        self.rating = rating
        self.images = images
        self.meter = meter
    }
    
    func setCategorie(categorie : String)
    {
        self.categorie = categorie
    }
    
    func getID() -> String
    {
        return self.id
    }
    
    func getTitle() -> String
    {
        return self.title
    }
    
    func getAddress() -> String
    {
        return self.address
    }
    
    func getLat() -> Double
    {
        return self.lat
    }
    
    func getLon() -> Double
    {
        return self.lon
    }
    
    func getCategorie() -> String
    {
        return self.categorie
    }
    
    func getRating() -> Float
    {
        return self.rating
    }
    
    func getOpen() -> Bool
    {
        return self.open
    }
    
    func getOpenHours() -> String
    {
        return self.opening_hours
    }
    
    func getImages() -> String
    {
        return self.images
    }
    
    func getHearts() -> Int
    {
        return self.hearts
    }
    
    func getDistance() -> Float
    {
        return self.distance
    }
    
    func getDescription() -> String
    {
        return self.description
    }
    
    func getMeter() -> Int
    {
        return self.meter
    }
}
