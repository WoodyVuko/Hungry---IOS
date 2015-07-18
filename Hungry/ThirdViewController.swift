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
    
    @IBOutlet weak var tmp: UIView!
    
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var hearts: UILabel!
    
    var data: NSData?
    static var arrayJSON : [JSONData] = [JSONData]()
    var counter: Int = 0
    var maximum: Int = 3

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
                tmp.setValue(UIImage(data:data!), forKeyPath: "image")

            }
            
            // Name
            tmp.setValue(ThirdViewController.arrayJSON[counter].getTitle() + ",", forKeyPath: "title")

            // Hearts
            tmp.setValue(String(ThirdViewController.arrayJSON[counter].getHearts()), forKeyPath: "heart")

            // Rating
            tmp.setValue(String(ThirdViewController.arrayJSON[counter].getRating()), forKeyPath: "rating")
        
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
    
    @IBAction func Cancel(sender: AnyObject)
    {
        print("Cancel!!!")
        
            
        
        UIViewController.reloadInputViews(self)()
    }
    @IBAction func Confirm(sender: AnyObject)
    {
        print("Confirm!!!")
        counter += 1;
        print(counter)
        let viewControllers: [UIViewController] = [UIViewController()]
        if let pageViewController = parentViewController as? UIPageViewController {
            pageViewController.setViewControllers(viewControllers, direction: .Forward, animated: true, completion: nil)
        }
        
        
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
