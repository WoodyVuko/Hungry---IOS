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
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    
    var data: NSData?
    static var arrayJSON : [JSONData] = [JSONData]()
    var counter: Int = 0
    var maximum: Int = 3
    
    var location = CGPoint(x: 0, y: 0)
    var order : Int = 1;
    var touchChoose : Int = 1
    var whichScreen : String = "Main"
    
    var chosenCategorie: String = ""
    
    var tmpOne: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 369)))
    var tmpTwo: Widget = Widget(frame: CGRect(origin: CGPoint(x: 10, y: 64), size: CGSize(width: 300, height: 369))) // 300, 369
    
    @IBOutlet var longPress: UILongPressGestureRecognizer!

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        longPress.minimumPressDuration = 1.0
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        // getData
        getDataJSON()

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;

        tmpOne.setTa(1)
        tmpTwo.setTa(2)
        self.view.addSubview(tmpTwo)
        self.view.addSubview(tmpOne)
        
        
        
    
    }

    override func viewDidAppear(animated: Bool) {
        print(ThirdViewController.arrayJSON.count)

        // Fill Data
        fillData(tmpOne, count: counter)
        fillData(tmpTwo, count: counter+1)
        

        
        
    }
    
    func fillData(tmp: Widget, count: Int) -> Widget
    {
        // Picture
        
        let url = NSURL(string: ThirdViewController.arrayJSON[count].getImages())
        data = NSData(contentsOfURL:url!)
        
        if data != nil {
            //pic?.image = UIImage(data:data!)
            tmp.image = UIImage(data:data!)!
            
        }
        
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
        if let touch = touches.first {
            
            /* Abgleich zwischen Objekten für Bewegung..*/
            
            /*
            print("Touch!")
            print(touch.view!.tag)

            print("Touches")
            print(touches.first!.view!.tag)

            */
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
        default:

            break
            
        }
    }
    
    func resetWidget(tmp : String)
    {
        if(tmp == "resetTmpOne")
        {
            self.view.sendSubviewToBack(tmpOne)
            tmpOne.center = CGPoint(x: 160, y: 250)
            order = 2
            tmpOne.alpha = 1.0
            touchChoose = 2
        }
        else if(tmp == "resetTmpTwo")
        {
            self.view.sendSubviewToBack(tmpTwo)
            tmpTwo.center = CGPoint(x: 160, y: 250)
            tmpTwo.alpha = 1.0
            order = 1
            touchChoose = 1
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
            default:
            break
            
        }
    }
    
    // MARK: Buttons
    
    @IBAction func Information(sender: AnyObject)
    {


        self.performSegueWithIdentifier("test", sender: self)
    
    }
    

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "test") {
            var svc = segue.destinationViewController as! ThirdViewControllerDetail;
           // self.whichScreen = "Detail"
            svc.whichScreen = "Detail"
            svc.tmp = ThirdViewController.arrayJSON[counter]
            
        }
    }

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
        acceptOrder()
    }
    
    // MARK: - GetJSON Categories
    
    func getDataJSON()
    {
        RestApiManager.sharedInstance.getLocals
        {
            json -> Void in
            
            // Finde Key "locations"
            // Durchsuche Dictionary nach Inhalt
            for result in json["locations"].arrayValue
            {
                let tmp2:JSONData = JSONData()
                let id = result["id"].intValue
                let google_id = result["google_id"].stringValue
                let yelp_id = result["yelp_id"].intValue
                let title = result["title"].stringValue
                let address = result["address"].stringValue
                let zip = result["zip"].intValue
                let city = result["city"].stringValue
                let lat = result["lat"].doubleValue
                let lon = result["lon"].doubleValue
                let categories = result["categories"].stringValue
                let rating = result["rating"].floatValue
                let open = result["open"].boolValue
                let opening_hours = result["opening_hours"].stringValue
                let images = result["images"].arrayValue
                let hearts = result["hearts"].intValue
                let distance = result["distance"].floatValue
                let description = result["description"].stringValue
                
                //let categories = result["categories"].arrayValue
                //str.append(categories[0].stringValue)
                //print(title)
                tmp2.loadIn(id, google_id: google_id, yelp_id: yelp_id, title: title, address: address, zip: zip, city: city, lat: lat, lon: lon, categorie: categories, rating: rating, open: open, opening_hours: opening_hours, images: images[0].stringValue, hearts: hearts, distance: distance, description: description)
                
                ThirdViewController.arrayJSON.append(tmp2)
            }
        }
    }

}
