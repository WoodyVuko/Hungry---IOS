//
//  JSONData.swift
//  Hungry
//
//  Created by Goran Vukovic on 17.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

class JSONData
{
    private var id : Int = 0
    private var google_id : String = ""
    private var yelp_id : Int = 0
    private var title : String = ""
    private var address : String = ""
    private var zip : Int = 0
    private var city : String = ""
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
    
    func loadIn(id : Int, google_id : String, yelp_id : Int, title : String, address : String, zip : Int, city : String, lat : Double, lon : Double, categorie : String, rating : Float, open : Bool, opening_hours : String, images : String, hearts : Int, distance : Float, description : String)
    {
        self.id = id;
        self.google_id = google_id
        self.yelp_id = yelp_id
        self.title = title
        self.address = address
        self.zip = zip
        self.city = city
        self.lat = lat
        self.lon = lon
        self.categorie = categorie
        self.rating = rating
        self.open = open
        self.opening_hours = opening_hours
        self.images = images
        self.hearts = hearts
        self.distance = distance
        self.description = description
    }
    
    func setCategorie(categorie : String)
    {
        self.categorie = categorie
    }
    
    func getID() -> Int
    {
        return self.id
    }
    
    func getGoogleID() -> String
    {
        return self.google_id
    }
    
    func getYelpID() -> Int
    {
        return self.yelp_id
    }
    
    func getTitle() -> String
    {
        return self.title
    }
    
    func getAddress() -> String
    {
        return self.address
    }
    
    func getZip() -> Int
    {
        return self.zip
    }
    
    func getCity() -> String
    {
        return self.city
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
}
