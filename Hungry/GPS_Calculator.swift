//
//  JSONParser.swift
//  Hungry
//
//  Created by Goran Vukovic on 14.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import Foundation

func DegreesToRadians (value:Double) -> Double {
    return value * M_PI / 180.0
}

func RadiansToDegrees (value:Double) -> Double {
    return value * 180.0 / M_PI
}

public func distanceInKm(lat1: Double, lon1: Double, lat2: Double, lon2: Double) -> Double{
    var radius: Int = 6371
    var lat: Double = DegreesToRadians(lat2 - lat1)
    var lon: Double = DegreesToRadians(lon2 - lon1)
    var a: Double = sin(lat / 2) * sin(lat / 2) + cos(DegreesToRadians(lat1)) * cos(DegreesToRadians(lat2)) * sin(lon / 2) * sin(lon / 2)
    var c: Double = 2 * atan2(sqrt(a), sqrt(1 - a))
    var d: Double = Double(radius) * c
    return d
}