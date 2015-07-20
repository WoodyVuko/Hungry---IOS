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
    
    @IBOutlet weak var tmpOne: UIView!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    
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
        print(ThirdViewController.arrayJSON.count)
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
            

           // print(touch.view?.viewWithTag(2))
            //touches.
           
            if (touches.first!.view! == self.view!.viewWithTag(3)!.viewWithTag(3))  {
                let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController

                self.presentViewController(next, animated: true, completion: nil)
            }
           
            if (touches.first!.view! == self.view!.viewWithTag(2)!)  {
                print("Map!!")
            }
            /*
            if (touch.view!.viewWithTag(3) == tmpOne)  {
                print("Widget, done")
                
            }
            */
            //print(touches.first!.view!)
            //print(self.view!.viewWithTag(2)!)
            
            let tapCount = touch.tapCount
            
            switch tapCount {
                case 1:
                    
                break
            case 2:
               // print("Doppelt!")

                return
            default: break
            }
            
        }
        super.touchesBegan(touches, withEvent:event)
    }
    
    @IBAction func makeMap(sender: AnyObject) {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("MapDetailController") as! MapDetailController
        next.tmp = self.tmp
        self.presentViewController(next, animated: false, completion: nil)
    }
}
