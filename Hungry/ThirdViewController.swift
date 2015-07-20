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
    
    var chosenCategorie: String = ""

    var tmpOne: Widget = Widget(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 369)))
    var tmpTwo: Widget = Widget(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: CGSize(width: 300, height: 369)))

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        // getData
        getDataJSON()

        UIApplication.sharedApplication().networkActivityIndicatorVisible = false;
        tmpOne.tag = 1
        tmpTwo.tag = 2
        self.view.addSubview(tmpOne)
        self.view.addSubview(tmpTwo)

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
    
   /*
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            location = touch.locationInView(self.view)
            
            // tmpOne.center.y = location.y - 100
            // tmpOne.center.x = location.x
            

            if(order == 1)
            {
                let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewControllerDetail") as! ThirdViewControllerDetail
                next.tmpOne = tmpOne
                next.tmpTwo = tmpTwo
                next.tmpThree = tmpThree
                self.presentViewController(next, animated: true, completion: nil)

            }
            else if(order == 2)
            {
                tmpTwo.center.x = location.x
            }
            else if(order == 3)
            {
                tmpThree.center.x = location.x
            }

        }
        super.touchesBegan(touches, withEvent:event)
    }


    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {

            location = touch.locationInView(self.view)
            
            // Check which Object is Active
            if(order == 1)
            {
                tmpOne.center.x = location.x
            }
            else if(order == 2)
            {
                tmpTwo.center.x = location.x
            }
            else if(order == 3)
            {
                tmpThree.center.x = location.x
            }
            
            //print(tmpOne.center)
            if(location.x <= 63)
            {
                print("Decline" + String(tmpOne.alpha))
                helpDistance(true)
   
            }
            else if(location.x >= 257)
            {
                print("Acceppt" + String(tmpOne.alpha))
                helpDistance(false)

            }
            else
            {
                /* Center if stopped...
                if(order == 1)
                {
                    tmpOne.center.x = touches.first
                }
                else if(order == 2)
                {
                    tmpTwo.center.x = location.x
                }
                else if(order == 3)
                {
                    tmpThree.center.x = location.x
                }
                */
            }
        }
        super.touchesBegan(touches, withEvent:event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            location = touch.locationInView(self.view)
            //helpOrder()
            
            
        }
        super.touchesBegan(touches, withEvent:event)

    }
    
    // MARK: Help Classes
    
    func helpOrder()
    {
        switch(order)
        {
        case(1):
            tmpOne.center.x = location.x
            //print(tmpOne.center)
            if(location.x <= 63)
            {
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpOne)
                order++
                // Reset Alpha
                tmpOne.alpha = 1.0
            }
            else if(location.x >= 257)
            {
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpOne)
                order++
                // Reset Alpha
                tmpOne.alpha = 1.0
            }
            break
        case(2):
            tmpTwo.center.x = location.x
            //print(tmpOne.center)
            if(location.x <= 63)
            {
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpTwo)
                order++
                // Reset Alpha
                tmpTwo.alpha = 1.0
            }
            else if(location.x >= 257)
            {
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpTwo)
                order++
                // Reset Alpha
                tmpTwo.alpha = 1.0
            }
            break
        case(3):
            tmpThree.center.x = location.x
            //print(tmpOne.center)
            if(location.x <= 63)
            {
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpThree)
                order = 1
                // Reset Alpha
                tmpThree.alpha = 1.0
            }
            else if(location.x >= 257)
            {
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpThree)
                order = 1
                // Reset Alpha
                tmpThree.alpha = 1.0
            }
            
            break
        default:

            break
            
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
    */
    // MARK: Buttons
    
    @IBAction func Information(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewControllerDetail") as! ThirdViewControllerDetail
        next.tmp = ThirdViewController.arrayJSON[counter]
        self.presentViewController(next, animated: true, completion: nil)
    }
    
    func cancelOrder()
    {
        switch(order)
        {
        case(1):
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpOne)
            order++
            break
        case(2):
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpTwo)
            order = 1
            break
        default:
            
            break
            
        }
    }
    
    func acceptOrder()
    {
        switch(order)
        {
        case(1):
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpOne)
            order++
            break
        case(2):
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpTwo)
            order = 1
            break
        default:
            
            break
            
        }
    }
    
    
    @IBAction func Cancel(sender: AnyObject)
    {
        //cancelOrder()
    }
    @IBAction func Confirm(sender: AnyObject)
    {
        //acceptOrder()
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
