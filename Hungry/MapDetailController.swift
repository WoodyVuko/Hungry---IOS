//
//  ThirdViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 15.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//


import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Foundation
import MapKit
import Contacts

class MapDetailController: UIViewController
{
    @IBOutlet weak var mapView: MKMapView!


    var tmp : JSONData = JSONData();
    var data: NSData?
    
    var manager = CLLocationManager()
    var initialLocation = CLLocation(latitude: 0, longitude: 0)
    
    var location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let regionRadius: CLLocationDistance = 1000
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        // Init
        location.latitude = tmp.getLat()
        location.longitude = tmp.getLon()
        initialLocation = CLLocation(latitude: tmp.getLat(), longitude: tmp.getLon())
        
        manager = CLLocationManager()
        manager.requestWhenInUseAuthorization()
        
        centerMapOnLocation(initialLocation)
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
    }
    
    override func viewDidAppear(animated: Bool) {

    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
            regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
        
        let artwork = MapAnnotations(title: tmp.getTitle(),
            locationName: tmp.getAddress(),
            discipline: "Location",
            coordinate: CLLocationCoordinate2D(latitude: tmp.getLat(), longitude: tmp.getLon()))
        
        mapView.addAnnotation(artwork)
    }
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!,
        calloutAccessoryControlTapped control: UIControl!) {
            let location = view.annotation as! MapAnnotations
            let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
            location.mapItem().openInMapsWithLaunchOptions(launchOptions)
    }

    @IBAction func mapButtonTapped(sender: AnyObject) {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: tmp.getLat(), longitude: tmp.getLon()), addressDictionary: [String(CNPostalAddressStreetKey): tmp.getAddress()])
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = tmp.getTitle()
        
        MKMapItem.openMapsWithItems([mapItem], launchOptions: [:])
    }

    
    
    @IBAction func closeMap(sender: AnyObject) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewControllerDetail") as! ThirdViewControllerDetail
        next.tmp = self.tmp
        self.presentViewController(next, animated: false, completion: nil)
    }
}
