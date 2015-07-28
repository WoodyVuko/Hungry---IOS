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


class FilterViewController: UIViewController, FBSDKLoginButtonDelegate
{
    // Facebook
    @IBOutlet weak var userImage: FBSDKProfilePictureView!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var shareButton: FBSDKShareButton!
    
    @IBOutlet weak var distanceSlide: UISlider!
    @IBOutlet weak var priceSlide: UISlider!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
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
    }
    
    @IBAction func changeDistance(sender: AnyObject)
    {
        ThirdViewController.distance = Int(distanceSlide.value)
        distance.text = String(Int(distanceSlide.value))
    }
    
    @IBAction func changePrice(sender: AnyObject)
    {
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
        shareButton.enabled = false
        // End Content...
        
        distance.text = String(Int(ThirdViewController.distance))
        distanceSlide.value = Float(ThirdViewController.distance) + 500.00
        showUserInfo()
    }
    
    // MARK: - Facebook Login
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil
        {
            loginButton.readPermissions = ["user_friends"]
            loginButton.delegate = self
            print("Login complete.")
            
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else
        {
            print(error.localizedDescription)
        }
    }
    
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
        userName.text = "UserName"
        shareButton.enabled = false
        
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        self.navigationController!.pushViewController(next, animated: true)
    }

    func showUserInfo()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                print("User Name is: \(userName)")
                //let userEmail : NSString = result.valueForKey("email") as! NSString
                //print("User Email is: \(userEmail)")
                self.userName.text = userName as String
                //self.userEmail.text = userEmail as String
                self.shareButton.enabled = true
                
            }
        })
        
        var request = FBSDKGraphRequest(graphPath:"/me/friends", parameters: nil);
        
        request.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            if error == nil {
                print("Friends are : \(result)")
            } else {
                print("Error Getting Friends \(error)");
            }
        }
    }

    

}