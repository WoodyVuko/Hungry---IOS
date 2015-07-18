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
    
    @IBOutlet weak var tmpOne: UIView!
    @IBOutlet weak var tmpTwo: UIView!
    @IBOutlet weak var tmpThree: UIView!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    
    var data: NSData?
    static var arrayJSON : [JSONData] = [JSONData]()
    var counter: Int = 0
    var maximum: Int = 3
    
    var location = CGPoint(x: 0, y: 0)
    var order : Int = 1;
    
    var chosenCategorie: String = ""
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        // getData
        getDataJSON()

        /*
        for(var i : Int = 0; i < ThirdViewController.arrayJSON.count; i++)
        {
            print(ThirdViewController.arrayJSON[i].getTitle())
            print(ThirdViewController.arrayJSON[i].getImages())
        }
        */
    }
    
    override func viewDidAppear(animated: Bool) {
        print(ThirdViewController.arrayJSON.count)
        //if(counter < maximum)
        //{
            // Picture
        
        let url = NSURL(string: ThirdViewController.arrayJSON[counter].getImages())
            data = NSData(contentsOfURL:url!)
            
            if data != nil {
                //pic?.image = UIImage(data:data!)
                tmpOne.setValue(UIImage(data:data!), forKeyPath: "image")
                tmpTwo.setValue(UIImage(data:data!), forKeyPath: "image")
                tmpThree.setValue(UIImage(data:data!), forKeyPath: "image")

            }
            
            // Name
        tmpOne.setValue(ThirdViewController.arrayJSON[counter].getTitle() + ",", forKeyPath: "title")
        tmpTwo.setValue(ThirdViewController.arrayJSON[counter+1].getTitle() + ",", forKeyPath: "title")
        tmpThree.setValue(ThirdViewController.arrayJSON[counter+2].getTitle() + ",", forKeyPath: "title")
        
        // Hearts
        tmpOne.setValue(String(ThirdViewController.arrayJSON[counter].getHearts()), forKeyPath: "heart")
        tmpTwo.setValue(String(ThirdViewController.arrayJSON[counter+1].getHearts()), forKeyPath: "heart")
        tmpThree.setValue(String(ThirdViewController.arrayJSON[counter+2].getHearts()), forKeyPath: "heart")

        // Rating
        tmpOne.setValue(String(ThirdViewController.arrayJSON[counter].getRating()), forKeyPath: "rating")
        tmpTwo.setValue(String(ThirdViewController.arrayJSON[counter+1].getRating()), forKeyPath: "rating")
        tmpThree.setValue(String(ThirdViewController.arrayJSON[counter+2].getRating()), forKeyPath: "rating")
        
            /*
            print(ThirdViewController.arrayJSON[0].getTitle())
            print(ThirdViewController.arrayJSON[0].getImages())

        }
        else
        {
            counter += 1
            //ThirdViewController.arrayJSON.removeLast()
        }*/
        /*
        for(var i : Int = 0; i < ThirdViewController.arrayJSON.count; i++)
        {
            print(ThirdViewController.arrayJSON[i].getTitle())
            print(ThirdViewController.arrayJSON[i].getImages())
        }
        */
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
            
            tmpOne.center.y = location.y - 100
            tmpOne.center.x = location.x

        }
        super.touchesBegan(touches, withEvent:event)
    }
*/
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            location = touch.locationInView(self.view)
            
            //tmpOne.center.y = location.y - 100
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
                //print("Decline" + String(tmpOne.alpha))
                helpDistance(true)
   
            }
            else if(location.x >= 257)
            {
                //print("Acceppt" + String(tmpOne.alpha))
                helpDistance(false)

            }
            else
            {
                //print(" ")
                //tmpOne.alpha = 1
            }
        }
        super.touchesBegan(touches, withEvent:event)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first {
            
            location = touch.locationInView(self.view)
            
            helpOrder()
            
            
        }
        super.touchesBegan(touches, withEvent:event)

    }
    
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
            }
            else if(location.x >= 257)
            {
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpOne)
            }
            order++
            break
        case(2):
            tmpTwo.center.x = location.x
            //print(tmpOne.center)
            if(location.x <= 63)
            {
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpTwo)
            }
            else if(location.x >= 257)
            {
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpTwo)
            }
            order++
            break
        case(3):
            tmpThree.center.x = location.x
            //print(tmpOne.center)
            if(location.x <= 63)
            {
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpThree)
            }
            else if(location.x >= 257)
            {
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpThree)
            }
            order = 1
            break
        default:

            break
            
        }
    }
    
    func helpDistance(let left: Bool)
    {
        /*
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
        */
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
            order++
            break
        case(3):
                print("Decline Nr. " + String(order))
                self.view.sendSubviewToBack(tmpThree)
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
            order++
            break
        case(3):
                print("Acceppt Nr. " + String(order))
                self.view.sendSubviewToBack(tmpThree)
            order = 1
            break
        default:
            
            break
            
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
                let lat = result["lat"].floatValue
                let lon = result["lon"].floatValue
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
