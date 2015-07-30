//
//  FilterViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 24.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit


class FilterViewController: UIViewController
{
    // Facebook
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var shareButton: FBSDKShareButton!
    
    @IBOutlet weak var distanceSlide: UISlider!
    @IBOutlet weak var priceSlide: UISlider!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var price: UILabel!
    var data: NSData?

    @IBAction func goRoot(sender: AnyObject)
    {
        goRoot()
    }
    
    @IBAction func openFav(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("FourthViewController") as! FourthViewController
        self.navigationController!.pushViewController(next, animated: true)
    }
    
    @IBAction func closeFilter(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController
        self.navigationController!.pushViewController(next, animated: true)
    }
    
    @IBAction func homeButton(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
        self.navigationController!.pushViewController(next, animated: true)
        
        ThirdViewController.arrayJSON.removeAll()
    }
    
    @IBAction func changeDistance(sender: AnyObject)
    {
        ThirdViewController.distance = Int(distanceSlide.value)
        distance.text = String(Int(distanceSlide.value))
    }
    
    @IBAction func goFeed(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("FriendViewController") as! FriendViewController
        self.navigationController!.pushViewController(next, animated: true)
        
    }
    @IBAction func goHistory(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("HistoryViewController") as! HistoryViewController
        self.navigationController!.pushViewController(next, animated: true)
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        // Content for Share...
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "https://google.de")
        content.contentTitle = "Hungry"
        content.contentDescription = "The easiest way to find your next food"
        content.imageURL = NSURL(string: "http://img09.deviantart.net/7d78/i/2011/136/e/8/monster__hungry_by_ivan_bliznak-d3ggvsq.jpg")
        shareButton.shareContent = content
        shareButton.enabled = true
        // End Content...
        
        distance.text = String(Int(ThirdViewController.distance))
        distanceSlide.value = Float(ThirdViewController.distance) + 1500.00
        getPicture()
        
    }
    
    func getPicture()
    {
        // Icon
        let u = String("http://graph.facebook.com/" + String(ViewController.fbID) + "/picture?width=146&height=146&redirect=false")
        let x = Just.get(u)
        let xx = x.json
        let ra = xx!.valueForKeyPath("data")  as! [String : AnyObject]
        let raa = ra["url"]
        let url = NSURL(string: String(raa!))
        data = NSData(contentsOfURL:url!)
        
        let img = UIImage(data:data!)
        
        if data != nil {
            userImage.image  = img?.circle
        }
    }

    
    func goRoot()
    {
        
        let loginManager = FBSDKLoginManager()
        loginManager.logOut() // this is an instance function
        
        print("loggedOut")
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.navigationController!.pushViewController(next, animated: true)
    }


}