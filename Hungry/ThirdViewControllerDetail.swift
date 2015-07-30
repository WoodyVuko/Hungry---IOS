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
    
    
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var shareButton: FBSDKShareButton!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    @IBOutlet weak var descript: UILabel!
    @IBOutlet weak var meter: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var touchChoose : Int = 1

    var croppingEnabled: Bool = false
    var locationFinger = CGPoint(x: 0, y: 0)

    var tmp : JSONData = JSONData();
    var counter: Int = 1
    var counterImage: Int = 0
    var order : Int = 1;

    var data: NSData?
    @IBOutlet var detailView: UIView!
  
    var manager = CLLocationManager()
    var initialLocation = CLLocation(latitude: 0, longitude: 0)
    
    var location:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    let regionRadius: CLLocationDistance = 1000
    var whichScreen : String = "Detail"

    var tmpOne: UIImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 300)))
    var tmpTwo: UIImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 300)))
    var tmpThree: UIImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 300)))
    var tmpFour: UIImageView = UIImageView(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 300))) //

    @IBOutlet var longPress: UILongPressGestureRecognizer!


    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        longPress.minimumPressDuration = 1.0

        
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

        descript.text = "Beschreibung: " + tmp.getDescription()
        hearts.text = String(tmp.getHearts())
        rating.text = String(tmp.getRating())
        meter.text = "Meter: " + String(tmp.getMeter())
        name.text = tmp.getTitle()
        
        if(tmp.getContainerLength() < 3)
        {
            counter = tmp.getContainerLength()
            print(counter)
        }
        else
        {
            counter = 3
            print(counter)
        }
        
        switch(counter)
        {
        case(1):
            print("1")
            tmpOne.tag = 1
            self.view.addSubview(tmpOne)
            break
            
        case(2):
            tmpOne.tag = 1
            tmpTwo.tag = 2
            self.view.addSubview(tmpTwo)
            self.view.addSubview(tmpOne)
            break
        case(3):
            tmpOne.tag = 1
            tmpTwo.tag = 2
            tmpThree.tag = 3
            self.view.addSubview(tmpThree)
            self.view.addSubview(tmpTwo)
            self.view.addSubview(tmpOne)
            break
        default:
            break
        }

        
    }
    
    func fill(image: UIImageView, tmp: Int)
    {
        //print(self.tmp.getContainerLength())
        let url = NSURL(string: String(self.tmp.getContainer(tmp)["image"]!))
        data = NSData(contentsOfURL:url!)
        
        if data != nil {
            image.setValue(UIImage(data:data!), forKeyPath: "image")
        }
    }
    
    func loadPic()
    {
        
        dispatch_async(dispatch_get_main_queue(), {

        switch(self.counter)
        {
        case(1):
            self.fill(self.tmpOne, tmp: 0)
            break
            
        case(2):
            self.fill(self.tmpOne, tmp: 0)
            self.fill(self.tmpTwo, tmp: 1)
            break
        case(3):
            self.fill(self.tmpOne, tmp: 0)
            self.fill(self.tmpTwo, tmp: 1)
            self.fill(self.tmpThree, tmp: 2)
            break
        default:
            break
        }
            })
        
        activity.stopAnimating()
        activity.alpha = 0
    }
    
    override func viewDidAppear(animated: Bool)
    {
        activity.alpha = 1
        activity.startAnimating()

        let timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("loadPic"), userInfo: nil, repeats: false);
            
        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
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
    
    // - Mark Touch - Swipe

    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first
        {
            locationFinger = touch.locationInView(self.view)
            
            switch(whichScreen)
            {
            case("Detail"):
                switch(touchChoose)
                {
                case(1):
                    tmpOne.center.x = locationFinger.x
                    alphaFunction()
                    break
                case(2):
                    tmpTwo.center.x = locationFinger.x
                    alphaFunction()
                    break
                case(3):
                    tmpThree.center.x = locationFinger.x
                    alphaFunction()
                    break
                case(3):
                    break
                default:
                    break
                }
                break
            default:
                break
            }
            super.touchesBegan(touches, withEvent:event)
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
                        
            
            locationFinger = touch.locationInView(self.view)
            switch(whichScreen)
            {
            case("Detail"):
                switch(touchChoose)
                {
                case(1):
                    tmpOne.center.x = locationFinger.x
                    self.tmpOne.removeFromSuperview()
                    touchChoose++
                    break
                case(2):
                    tmpTwo.center.x = locationFinger.x
                    self.tmpTwo.removeFromSuperview()
                    touchChoose++
                    break
                case(3):
                    tmpThree.center.x = locationFinger.x
                        self.tmpThree.removeFromSuperview()
                    touchChoose++
                    break
                default:
                    break
                }
                break
            default:
                break
            }
        }
        super.touchesBegan(touches, withEvent:event)
        
    }
    
    // MARK: Help Classes
    
    
    
    func alphaFunction()
    {
        if(locationFinger.x <= 63)
        {
            helpDistance(true)
            
        }
        else if(locationFinger.x >= 237)
        {
            helpDistance(false)
            
        }
        else
        {
            helpDistance(false)
        }
        
    }
    func helpDistance(let left: Bool)
    {
        switch(order)
        {
        case(1):
            if(left == true)
            {
                if(tmpOne.alpha > 0.3)
                {
                    tmpOne.alpha -= 0.1
                }
                else
                {
                    tmpOne.alpha = 0.3
                }
            }
            else
            {
                if(tmpOne.alpha < 1)
                {
                    tmpOne.alpha += 0.1
                }
                else
                {
                    tmpOne.alpha = 1.0
                }
            }
            break
        case(2):
            if(left == true)
            {
                if(tmpTwo.alpha > 0.3)
                {
                    tmpTwo.alpha -= 0.1
                }
                else
                {
                    tmpTwo.alpha = 0.3
                }
            }
            else
            {
                if(tmpTwo.alpha < 1)
                {
                    tmpTwo.alpha += 0.1
                }
                else
                {
                    tmpTwo.alpha = 1.0
                }
            }
            break
        case(3):
            if(left == true)
            {
                if(tmpThree.alpha > 0.3)
                {
                    tmpThree.alpha -= 0.1
                }
                else
                {
                    tmpThree.alpha = 0.3
                }
            }
            else
            {
                if(tmpThree.alpha < 1)
                {
                    tmpThree.alpha += 0.1
                }
                else
                {
                    tmpThree.alpha = 1.0
                }
            }
            break
        default:
            break
            
        }
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
    
    @IBAction func heartRating(sender: AnyObject)
    {
        let myUrl: String = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/json/rating"
        
        let param = [
            "password" : "a8JwAkBy",
            "username" : "hangry",
            "fb_id" : String(ViewController.fbID),
            "place_id" : String(tmp.getID()),
            "heart" : "1"
        ]
        
    
        let r = Just.post(myUrl, json: param)
        
        if (r.ok)
        {
            // Return Server
            let tmp = r.json
            
            let rating : Int = tmp!.valueForKeyPath("rating") as! Int
            let counter : Int = tmp!.valueForKeyPath("counter") as! Int

            print(tmp)
            if( rating == 0)
            {
                print("Heart posted")
                self.hearts.text! = String(counter)
            }
            else
            {
                self.hearts.text! = String(counter)
                print("Heart bereits gepostet!")   
            }
        }
    }
}
