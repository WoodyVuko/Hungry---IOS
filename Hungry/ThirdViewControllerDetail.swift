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
import FBSDKShareKit
import MapKit
import AddressBook

class ThirdViewControllerDetail: UIViewController
{
    //@IBOutlet weak var Button: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pic: UIImageView!
    
    var tmpOne: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 339)))
    
    @IBOutlet weak var shareButton: FBSDKShareButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var meter: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var croppingEnabled: Bool = false

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
        
        
        
        // Content for Share...
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "https://hungry-app.com")
        content.contentTitle = String(tmp.getTitle())
        content.contentDescription = String(tmp.getAddress())
        content.imageURL = NSURL(string: String(tmp.getImages()))
        shareButton.shareContent = content
        shareButton.enabled = true
        // End Content...
        
        
        descript.text = tmp.getDescription()
        
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
        
        meter.text = String(tmp.getMeter()) + " Meter"
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
            if(longPress.state == UIGestureRecognizerState.Began)
            {

                let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController
        
                next.whichScreen = "Main"
                self.navigationController!.pushViewController(next, animated: true)
            }
/*
        self.whichScreen = "Main"
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController
        next.whichScreen = "Main"
        next.counter = self.counter
        self.presentViewController(next, animated: false, completion: nil)
*/
    }
    @IBAction func openCamera(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("CameraViewController") as! CameraViewController
        //next.whichScreen = "Main"
        //next.counter = self.counter
        next.tmp = self.tmp
        self.presentViewController(next, animated: false, completion: nil)

    }
    
    func uploadFunction()
    {
        let myUrl: String = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/rating"
        
        
        let param = [
            "password" : "a8JwAkBy",
            "username" : "hangry",
            "fb_id" : String(ViewController.fbID),
            "place_id" : String(tmp.getID()),
            "heart" : String(tmp.getHearts() + 1)
    ]
    
        //  talk to registration end point
        let r = Just.post(
            myUrl,
            data: param
        )
        print(r.response)
        print(r.statusCode)
        if (r.ok)
        {
            print("Heart posted")
        }
    }
    
    @IBAction func heartRating(sender: AnyObject)
    {
        /*
        let myUrl: String = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/rating"
        
        
        let param = [
            "password" : "a8JwAkBy",
            "username" : "hangry",
            "fb_id" : String(ViewController.fbID),
            "place_id" : String(tmp.getID()),
            "heart" : "1"
        ]
        
    
        let r = Just.post(myUrl, params: param)
        
        print("***************************************")
        print(r.response)
        print(r.statusCode)
        if (r.ok)
        {
            print("Heart posted")
        }
*/
        let myUrl: String = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/rating"
        
        
        var one : NSString = "a8JwAkBy"
        var two : NSString = "hangry"
        var three : NSString = "a8JwAkBy"
        var four : NSString = "a8JwAkBy"
        var five : NSString = "a8JwAkBy"
        
        var on = one.dataUsingEncoding(NSUTF8StringEncoding)
        var tw = two.dataUsingEncoding(NSUTF8StringEncoding)
        var th = three.dataUsingEncoding(NSUTF8StringEncoding)
        var fo = four.dataUsingEncoding(NSUTF8StringEncoding)
        var fi = five.dataUsingEncoding(NSUTF8StringEncoding)
        
        let param = [
            "password" : "a8JwAkBy",
            "username" : "hangry",
            "fb_id" : String(ViewController.fbID),
            "place_id" : String(tmp.getID()),
            
        ]
        
        
        
        /*  talk to registration end point
        let r = Just.post(
        myUrl,
        data: param
        )
        */
        
        let r = Just.post(myUrl, files: [
            "password":HTTPFile.reinerText(on!, "multipart/form-data"),
            "username":HTTPFile.reinerText(tw!, "multipart/form-data"),
            "fb_id":HTTPFile.reinerText(th!, "multipart/form-data"),
            "place_id":HTTPFile.reinerText(fo!, "multipart/form-data"),
            "heart":HTTPFile.reinerText(fi!, "multipart/form-data")
            ])
        
        print("***************************************")
        print(r.response)
        print(r.statusCode)
        if (r.ok)
        {
            print("Heart posted")
        }
    
    }
}
