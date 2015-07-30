//
//  ViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 12.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class ViewController: UIViewController , FBSDKLoginButtonDelegate
{
    @IBOutlet weak var userImage: FBSDKProfilePictureView!
    @IBOutlet weak var loginButton: FBSDKLoginButton!
    @IBOutlet weak var loginInfo: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userEmail: UILabel!
    @IBOutlet weak var shareButton: FBSDKShareButton!
    static var fbID : Int = 0
    static var fbinfo : [FriendInfo]  = [FriendInfo]()
    static var fbName : String = ""
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        loginButton.delegate = self
        
        self.navigationController?.navigationBarHidden = true
        // Content for Share...
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = NSURL(string: "https://google.de")
        content.contentTitle = "Hungry"
        content.contentDescription = "The easiest way to find your next food"
        content.imageURL = NSURL(string: "http://img09.deviantart.net/7d78/i/2011/136/e/8/monster__hungry_by_ivan_bliznak-d3ggvsq.jpg")
        shareButton.shareContent = content
        shareButton.enabled = false
        // End Content...
        
        loginButton.readPermissions = ["user_friends", "user_posts", "public_profile", "email", ]
        loginButton.delegate = self
        
        if((FBSDKAccessToken.currentAccessToken()==nil))
        {
            print("Not logged in..")
            loginInfo.text = "Not logged in.."
            userName.text = "UserName"
            userEmail.text = "UserEmail"
            shareButton.enabled = false
        }
        else
        {
            print("Logged in..")
            showUserInfo()
            
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
            /* self.presentViewController(next, animated: true, completion: nil)
            */
            self.navigationController!.pushViewController(next, animated: true)
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Facebook Login
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        
        if error == nil
        {
            print("Login complete.")
            showUserInfo()
            let next = self.storyboard?.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
            /* self.presentViewController(next, animated: true, completion: nil)
            */
            self.navigationController!.pushViewController(next, animated: true)
            

        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else
        {
            
            if result.grantedPermissions.contains("user_friends")
            {
                loginButton.readPermissions = ["user_friends"]

            }
            print(error.localizedDescription)
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
        loginInfo.text = "Not logged in.."
        userName.text = "UserName"
        userEmail.text = "UserEmail"
        shareButton.enabled = false
    }
    
    //顯示使用者資料
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
               // print("fetched user: \(result)")
                let userName : NSString = result.valueForKey("name") as! NSString
                let id : NSString = result.valueForKey("id") as! NSString
                
                // Übergabe der FBID
                ViewController.fbID = Int(id as String)!
                
                ViewController.fbName = userName as String
                print("User Name is: \(userName)")
                //let userEmail : NSString = result.valueForKey("email") as! NSString
                //print("User Email is: \(userEmail)")
                self.loginInfo.text = "Logged in.."
                self.userName.text = userName as String
                //self.userEmail.text = userEmail as String
                self.shareButton.enabled = true
            
            }
        })
       // /me/ids_for_business
        let request = FBSDKGraphRequest(graphPath:"/me/friends", parameters: nil);
        
        request.startWithCompletionHandler { (connection : FBSDKGraphRequestConnection!, result : AnyObject!, error : NSError!) -> Void in
            if error == nil {
                let infos = result!["data"] as! [[String : AnyObject]]
                for inf in infos
                {
                    let tmp : FriendInfo = FriendInfo()
                    let id = inf["id"]!
                    let name = inf["name"]!

                    tmp.loadIn(String(id), name: String(name))
                    
                    ViewController.fbinfo.append(tmp)
                }
            } else {
                print("Error Getting Friends \(error)");
            }
        }

    }
}




