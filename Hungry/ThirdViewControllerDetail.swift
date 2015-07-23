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
import MapKit
import AddressBook

class ThirdViewControllerDetail: UIViewController
{
    //@IBOutlet weak var Button: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    var tmpOne: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 369)))
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    @IBOutlet weak var descript: UILabel!

    var tmp : JSONData = JSONData();
    var counter: Int = 0
    var data: NSData?
    @IBOutlet var detailView: UIView!
  
    var manager = CLLocationManager()
    var initialLocation = CLLocation(latitude: 0, longitude: 0)
    
    var location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let regionRadius: CLLocationDistance = 1000
    var whichScreen : String = "Detail"

    @IBOutlet var longPress: UILongPressGestureRecognizer!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        longPress.minimumPressDuration = 1.0
        
        tmpOne.setTa(3)
        self.view.addSubview(tmpOne)
        
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
        //if(counter < maximum)
        //{
            // Picture
        
        let url = NSURL(string: tmp.getImages())
            data = NSData(contentsOfURL:url!)
            
            if data != nil {
                tmpOne.setValue(UIImage(data:data!), forKeyPath: "image")
     
            }
            
            // Name
        tmpOne.setValue(tmp.getTitle() + ",", forKeyPath: "title")
        // Hearts
        tmpOne.setValue(String(tmp.getHearts()), forKeyPath: "heart")
        // Rating
        tmpOne.setValue(String(tmp.getRating()), forKeyPath: "rating")
        // Description
        descript.text = tmp.getDescription()
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
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            /* Abgleich zwischen Objekten für Bewegung..*/
            
            /*
            print("Touch!")
            print(touch.view!.tag)
            
            print("Touches")
            print(touches.first!.view!.tag)
            

            switch(whichScreen)
            {
            case("Main"):
                
                break
            default:
                break
            }*/
            
            switch(whichScreen)
            {
            case("Detail"):
                if(( touch.view!.tag == touches.first!.view!.tag) && touch.view!.tag == 3)
                {

                }
                else
                {
                    print(touch.view!)
                    print("XXAußerhalb!")
                            
                }
                break
            default:
                break
            }

            
            
        }
        super.touchesBegan(touches, withEvent:event)
    }

    @IBAction func makeMap(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("MapDetailController") as! MapDetailController
        next.tmp = self.tmp
        self.presentViewController(next, animated: false, completion: nil)
        
    }
    
    @IBAction func goMain(sender: AnyObject)
    {
        
        dismissViewControllerAnimated(false, completion:nil)
        self.whichScreen = "tmp"
        print(whichScreen)

        dismissViewControllerAnimated(false, completion:nil)
/*
        self.whichScreen = "Main"
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController
        next.whichScreen = "Main"
        next.counter = self.counter
        self.presentViewController(next, animated: false, completion: nil)
*/
    }
}
