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

class ViewController: UIViewController, FBSDKLoginButtonDelegate
{
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in...")
        }
        else
        {
            print("Logged in...")
            NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdated:", name:FBSDKAccessTokenDidChangeNotification, object: nil)
            print("\(FBSDKAccessToken.currentAccessToken().userID)")
            print("\(FBSDKProfile.currentProfile().name)")

            //self.performSegueWithIdentifier("test", sender: self)
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        loginButton.enabled = true
        loginButton.delegate = self
        self.view.addSubview(loginButton)
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Facebook Login
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            print("Login complete.")
            self.performSegueWithIdentifier("showNew", sender: self)
            //print("\(FBSDKProfile.currentProfile().name)")

        }
        else
        {
            print(error.localizedDescription)
        }
        
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        print("User logged out...")
    }
    
    func onTokenUpdated(notification: NSNotification) {
        print(FBSDKProfile.currentProfile().name)
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            print("token is not nil ")
        } else {
            print("token is nil")
        }
    }
    
}


