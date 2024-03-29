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

class ThirdViewController: UIViewController
{
    //@IBOutlet weak var Button: UIButton!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var pic: UIImageView!
    @IBOutlet weak var closeSidebar: UIButton!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    @IBOutlet weak var sideBarView: UIView!

    let myLocation: FindMyCoords = FindMyCoords()
    
    var data: NSData?
    static var arrayJSON : [JSONData] = [JSONData]()
    static var myLocationLat : Double = 0
    static var myLocationLon : Double = 0
    static var distance : Int = 1500
    static var chosenCategorie: String = ""

    var counter: Int = 0
    var maximum: Int = 3
    
    var location = CGPoint(x: 0, y: 0)
    var order : Int = 1;
    var touchChoose : Int = 1
    var whichScreen : String = "Main"
    
    
    var tmpOne: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 84), size: CGSize(width: 300, height: 349)))
    var tmpTwo: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 84), size: CGSize(width: 300, height: 349)))
    var tmpThree: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 84), size: CGSize(width: 300, height: 349)))
    //var tmpFour: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 84), size: CGSize(width: 300, height: 349))) // 300, 369
    //var tmpFive: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 369)))
    //var tmpSix: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 369)))
    @IBOutlet var longPress: UILongPressGestureRecognizer!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.navigationController?.navigationBarHidden = true
        longPress.minimumPressDuration = 1.0
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        dispatch_async(dispatch_get_main_queue(),
            {
                self.getDataJSON()
            })
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;

        tmpOne.setTa(1)
        tmpTwo.setTa(2)
        tmpThree.setTa(3)

        self.view.addSubview(tmpThree)
        self.view.addSubview(tmpTwo)
        self.view.addSubview(tmpOne)
    }

    override func viewDidAppear(animated: Bool) {
        
       // fillData(tmpOne, count: counter)
       // fillData(tmpTwo, count: counter+1)
    }
    
    func fillData(tmp: Widget, count: Int) -> Widget
    {
        // Picture
        let url = NSURL(string: ThirdViewController.arrayJSON[count].getImages())
        data = NSData(contentsOfURL:url!)
        
        if data != nil {
            tmp.image = UIImage(data:data!)!
            
        }
        // ID
        tmp.id = count
        
        // Name
        tmp.title = ThirdViewController.arrayJSON[count].getTitle()
        
        // Hearts
        tmp.heart = String(ThirdViewController.arrayJSON[count].getHearts())
        
        // Rating
        tmp.rating = String(ThirdViewController.arrayJSON[count].getRating())
        
        return tmp
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let _ = touches.first {
            
            /* Abgleich zwischen Objekten für Bewegung..*/
            
            /*
            print("Touch!")
            print(touch.view!.tag)

            print("Touches")
            print(touches.first!.view!.tag)

            */
            /*
            switch(whichScreen)
            {
            case("Main"):
                if(( touch.view!.tag == touches.first!.view!.tag) && touch.view!.tag == 1)
                {
                    //print("1. Geklickt!")
                }
                else
                    if(( touch.view!.tag == touches.first!.view!.tag) && touch.view!.tag == 2)
                    {
                        //print("2. Geklickt!")
                    }
                    else
                        if(( touch.view!.tag == touches.first!.view!.tag) && touch.view!.tag == 3)
                        {
                            print("Pic")
                        }
                        else
                        {
                            print("Außerhalb!")
                            
                }
                break
            case("tmp"):
                print("temp!!!!")
                break
            default:
                break
            }
*/


        }
        super.touchesBegan(touches, withEvent:event)
    }
    
  
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first
        {
            location = touch.locationInView(self.view)

            switch(whichScreen)
            {
            case("Main"):
                switch(touchChoose)
                {
                case(1):
                    tmpOne.center.x = location.x
                    alphaFunction()
                    break
                case(2):
                    tmpTwo.center.x = location.x
                    alphaFunction()
                    break
                case(3):
                    tmpThree.center.x = location.x
                    alphaFunction()
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
            
            print(String(ThirdViewController.arrayJSON.count) + "----" + String(counter))

            
            location = touch.locationInView(self.view)
            switch(whichScreen)
            {
            case("Main"):
                switch(touchChoose)
                {
                case(1):
                    tmpOne.center.x = location.x
                    helpOrder()
                    break
                case(2):
                    tmpTwo.center.x = location.x
                    helpOrder()
                    break
                case(3):
                    tmpThree.center.x = location.x
                    helpOrder()
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
    
    func helpOrder()
    {
        switch(order)
        {
        case(1):
            if(location.x <= 63)
            {
                resetWidget("resetTmpOne")

            }
            else if(location.x >= 237)
            {
                resetWidget("resetTmpOne")
            }
            else
            {

            }
            
            break
        case(2):
            if(location.x <= 63)
            {
                resetWidget("resetTmpTwo")
            }
            else if(location.x >= 237)
            {
                resetWidget("resetTmpTwo")
            }
            else
            {

            }
            break
        case(3):
            if(location.x <= 63)
            {
                resetWidget("resetTmpThree")
            }
            else if(location.x >= 237)
            {
                resetWidget("resetTmpThree")
            }
            else
            {
                
            }
            break
        default:

            break
            
        }
    }
    
    func resetWidget(tmp : String)
    {
        if(tmp == "resetTmpOne")
        {
            checkArrayLength(self.tmpOne)
            self.view.sendSubviewToBack(tmpOne)
            tmpOne.center = CGPoint(x: 160, y: 260)
            order = 2
            tmpOne.alpha = 1.0
            touchChoose = 2
        }
        else if(tmp == "resetTmpTwo")
        {
            checkArrayLength(self.tmpTwo)
            self.view.sendSubviewToBack(tmpTwo)
            tmpTwo.center = CGPoint(x: 160, y: 260)
            tmpTwo.alpha = 1.0
            order = 3
            touchChoose = 3
        }
        else if(tmp == "resetTmpThree")
        {
            checkArrayLength(self.tmpThree)
            self.view.sendSubviewToBack(tmpThree)
            tmpThree.center = CGPoint(x: 160, y: 260)
            tmpThree.alpha = 1.0
            order = 1
            touchChoose = 1
        }
    }
    
    func checkArrayLength(tmp: Widget)
    {
        
        //print("Check - " + String(self.counter))
        //print("Count - " + String(ThirdViewController.arrayJSON.count))
        if( self.counter < ThirdViewController.arrayJSON.count - 1)
        {
            self.counter++
            self.fillData(tmp, count: self.counter)
        }
        else
        {
            self.counter = 0
            print("Reset // Future Reload")
        }
    }
    
    func alphaFunction()
    {
        if(location.x <= 63)
        {
            helpDistance(true)
            
        }
        else if(location.x >= 237)
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
    
    // MARK: Buttons
    
    @IBAction func showSidebar(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("FilterViewController") as! FilterViewController
        self.navigationController!.pushViewController(next, animated: true)
    }

    
    @IBAction func Information(sender: AnyObject)
    {
        if(sender is UILongPressGestureRecognizer)
        {
            let name : UILongPressGestureRecognizer = sender as! UILongPressGestureRecognizer

             if(name.state == UIGestureRecognizerState.Began)
             {
                let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewControllerDetail") as! ThirdViewControllerDetail
                
                next.whichScreen = "Detail"
                switch(touchChoose)
                {
                case(1):
                    next.tmp = ThirdViewController.arrayJSON[tmpOne.id]
                    break
                case(2):
                    next.tmp = ThirdViewController.arrayJSON[tmpTwo.id]
                    break
                case(3):
                    next.tmp = ThirdViewController.arrayJSON[tmpThree.id]
                    break
                default:
                    break
                }
                
                self.navigationController!.pushViewController(next, animated: true)
            }
        }
        else
        {
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewControllerDetail") as! ThirdViewControllerDetail
            
            next.whichScreen = "Detail"
            switch(touchChoose)
            {
            case(1):
                next.tmp = ThirdViewController.arrayJSON[tmpOne.id]
                break
            case(2):
                next.tmp = ThirdViewController.arrayJSON[tmpTwo.id]
                break
            case(3):
                next.tmp = ThirdViewController.arrayJSON[tmpThree.id]
                break
            default:
                break
            }
            
            self.navigationController!.pushViewController(next, animated: true)
        }
    
    }
    

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
//        if (segue.identifier == "test") {
//            var svc = segue.destinationViewController as! ThirdViewControllerDetail;
//           // self.whichScreen = "Detail"
//            svc.whichScreen = "Detail"
//            svc.tmp = ThirdViewController.arrayJSON[counter]
//            
//        }
//    }

    
    func cancelOrder()
    {
        if(touchChoose == 1)
        {
            switch(order)
            {
            case(1):
                resetWidget("resetTmpOne")
                touchChoose = 2
                break
            case(2):
                resetWidget("resetTmpTwo")
                touchChoose = 3
                break
            case(3):
                resetWidget("resetTmpThree")
                touchChoose = 1
                break
            default:
                break
            }
        }
        else if(touchChoose == 2)
        {
            switch(order)
            {
            case(1):
                resetWidget("resetTmpOne")
                touchChoose = 2
                break
            case(2):
                resetWidget("resetTmpTwo")
                touchChoose = 3
                break
            case(3):
                resetWidget("resetTmpThree")
                touchChoose = 1
                break
            default:
                break
            }
        }
        else if(touchChoose == 3)
        {
            switch(order)
            {
            case(1):
                resetWidget("resetTmpOne")
                touchChoose = 2
                break
            case(2):
                resetWidget("resetTmpTwo")
                touchChoose = 3
                break
            case(3):
                resetWidget("resetTmpThree")
                touchChoose = 1
                break
            default:
                break
            }
        }
            
        else
        {
            
        }
    }
    
    
    func acceptOrder()
    {
        if(touchChoose == 1)
        {
            switch(order)
            {
            case(1):
                resetWidget("resetTmpOne")
                touchChoose = 2
                break
            case(2):
                resetWidget("resetTmpTwo")
                touchChoose = 3
                break
            case(3):
                resetWidget("resetTmpThree")
                touchChoose = 1
                break
            default:
                break
            }
        }
        else if(touchChoose == 2)
        {
            switch(order)
            {
            case(1):
                resetWidget("resetTmpOne")
                touchChoose = 2
                break
            case(2):
                resetWidget("resetTmpTwo")
                touchChoose = 3
                break
            case(3):
                resetWidget("resetTmpThree")
                touchChoose = 1
                break
            default:
                break
            }
        }
        else if(touchChoose == 3)
        {
            switch(order)
            {
            case(1):
                resetWidget("resetTmpOne")
                touchChoose = 2
                break
            case(2):
                resetWidget("resetTmpTwo")
                touchChoose = 3
                break
            case(3):
                resetWidget("resetTmpThree")
                touchChoose = 1
                break
            default:
                break
            }
        }
            
        else
        {
            
        }
    }
    
    
    @IBAction func Cancel(sender: AnyObject)
    {
        cancelOrder()
    }
    @IBAction func Confirm(sender: AnyObject)
    {
        loadFav()

        acceptOrder()
    }
    
    func loadFav()
    {
        /*
        let tmp: JSONData = JSONData()
        switch(self.touchChoose)
        {
            case(1):
                tmp.loadIn(ThirdViewController.arrayJSON[tmpOne.id].getID(), title: ThirdViewController.arrayJSON[tmpOne.id].getTitle(), address: ThirdViewController.arrayJSON[tmpOne.id].getAddress(), lat: ThirdViewController.arrayJSON[tmpOne.id].getLat(), lon: ThirdViewController.arrayJSON[tmpOne.id].getLon(), categorie: ThirdViewController.arrayJSON[tmpOne.id].getCategorie(), rating: ThirdViewController.arrayJSON[tmpOne.id].getRating(), images: ThirdViewController.arrayJSON[tmpOne.id].getImages(), meter: ThirdViewController.arrayJSON[tmpOne.id].getMeter(), heart: ThirdViewController.arrayJSON[tmpOne.id].getHearts(), description: ThirdViewController.arrayJSON[tmpOne.id].getDescription(), container: ThirdViewController.arrayJSON[tmpOne.id].getContainer(0) as! NSMutableArray)
            break
        case(2):
            tmp.loadIn(ThirdViewController.arrayJSON[tmpTwo.id].getID(), title: ThirdViewController.arrayJSON[tmpTwo.id].getTitle(), address: ThirdViewController.arrayJSON[tmpTwo.id].getAddress(), lat: ThirdViewController.arrayJSON[tmpTwo.id].getLat(), lon: ThirdViewController.arrayJSON[tmpTwo.id].getLon(), categorie: ThirdViewController.arrayJSON[tmpTwo.id].getCategorie(), rating: ThirdViewController.arrayJSON[tmpTwo.id].getRating(), images: ThirdViewController.arrayJSON[tmpTwo.id].getImages(), meter: ThirdViewController.arrayJSON[tmpTwo.id].getMeter(), heart: ThirdViewController.arrayJSON[tmpTwo.id].getHearts(), description: ThirdViewController.arrayJSON[tmpTwo.id].getDescription(), container: ThirdViewController.arrayJSON[tmpTwo.id].getContainer(0) as! NSMutableArray)
            break
        case(3):
            tmp.loadIn(ThirdViewController.arrayJSON[tmpThree.id].getID(), title: ThirdViewController.arrayJSON[tmpThree.id].getTitle(), address: ThirdViewController.arrayJSON[tmpThree.id].getAddress(), lat: ThirdViewController.arrayJSON[tmpThree.id].getLat(), lon: ThirdViewController.arrayJSON[tmpThree.id].getLon(), categorie: ThirdViewController.arrayJSON[tmpThree.id].getCategorie(), rating: ThirdViewController.arrayJSON[tmpThree.id].getRating(), images: ThirdViewController.arrayJSON[tmpThree.id].getImages(), meter: ThirdViewController.arrayJSON[tmpThree.id].getMeter(), heart: ThirdViewController.arrayJSON[tmpThree.id].getHearts(), description: ThirdViewController.arrayJSON[tmpThree.id].getDescription(), container: ThirdViewController.arrayJSON[tmpThree.id].getContainer(0) as! NSMutableArray)
            break
        default:
            break
        }
        PlistManager.defaultManager.updatePlist("Favoriten", key: "place_id", value: tmp.getID() )
        PlistManager.defaultManager.updatePlist("Favoriten", key: "name", value: tmp.getTitle())
        PlistManager.defaultManager.updatePlist("Favoriten", key: "image", value: tmp.getImages())
        PlistManager.defaultManager.updatePlist("Favoriten", key: "lat", value: tmp.getLat())
        PlistManager.defaultManager.updatePlist("Favoriten", key: "lon", value: tmp.getLon())
        PlistManager.defaultManager.updatePlist("Favoriten", key: "address", value: tmp.getAddress())
        PlistManager.defaultManager.updatePlist("Favoriten", key: "rating", value: tmp.getRating())
        
        //PlistManager.defaultManager.writeToPlist(<#T##fileName: String##String#>, key: <#T##String#>, value: <#T##AnyObject#>)
*/
    }
    // MARK: - GetJSON Categories
    
    func getDataJSON()
    {
        // search?geo_coord=52.5702249,13.404094&rad_filter=1000&cat_filter=italian

        RestApiManager.sharedInstance.localURL = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/search?" + "geo_coord=" + String(ThirdViewController.myLocationLat) + "," + String(ThirdViewController.myLocationLon) + "&rad_filter=" + String(ThirdViewController.distance) + "&cat_filter=" + String(ThirdViewController.chosenCategorie)
        
        print(RestApiManager.sharedInstance.localURL)
        RestApiManager.sharedInstance.getLocals
            {
                json -> Void in

                // Finde Key "locations"
                // Durchsuche Dictionary nach Inhalt
                for result in json["items"].arrayValue
                {
                    let tmp2:JSONData = JSONData()
                    let id = result["place_id"].stringValue
                    //                let google_id = result["google_id"].stringValue
                    //                let yelp_id = result["yelp_id"].intValue
                    let title = result["name"].stringValue
                    let address = result["address"].stringValue
                    let location = result["location"].arrayValue
                    let lat = location[0].doubleValue
                    let lon = location[1].doubleValue
                    let yelp_rating = result["yelp_rating"].floatValue

                    //                let categories = result["categories"].stringValue
                    let heart_rating = result["rating"].intValue
                    //                let open = result["open"].boolValue
                    //                let opening_hours = result["opening_hours"].stringValue
                    var image = result["images"].arrayValue
                    
                    let images = image[0]["image_url"].stringValue
                    let description_image = image[0]["image_description"].stringValue
                    
                    let cont : NSMutableArray = NSMutableArray()
                    //print("Hole")
                    for resultImage in image
                    {
                        let description_image = resultImage["image_description"].stringValue
                        _ = resultImage["image_url"].stringValue
                        _ = resultImage["fb_id"].stringValue
                    
                        let param = [
                            "image" : images,
                            "description" : description_image,
                            "fb_id" : ViewController.fbID
                        ]
                        
                        cont.addObject(param)
                        
                    }
                    
                    let meter: Int = Int(distanceInKm(ThirdViewController.myLocationLat, lon1: ThirdViewController.myLocationLon, lat2: lat, lon2: lon) * 1000)
                    tmp2.loadIn(id, title: title, address: address, lat: lat, lon: lon, categorie: ThirdViewController.chosenCategorie, rating: yelp_rating, images: images, meter: meter, heart: heart_rating, description : description_image, container: cont)

                    dispatch_async(dispatch_get_main_queue(), {
                        
                        ThirdViewController.arrayJSON.append(tmp2)
                        //print(tmp2.getTitle())
                        // Fill Data
                        if(self.counter == 0)
                        {
                            self.fillData(self.tmpOne, count: self.counter)
                            self.counter = 1
                        }
                        else if(self.counter == 1)
                        {
                            self.fillData(self.tmpTwo, count: self.counter)
                            self.counter = 2
                        }
                        else if(self.counter == 2)
                        {
                            self.fillData(self.tmpThree, count: self.counter)
                            self.counter = 3
                        }
                    })
                    
  
                    
                }
        }
    }
    
}
