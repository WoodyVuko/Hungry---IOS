//
//  DataViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 12.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//
import FBSDKLoginKit
import FBSDKCoreKit

import UIKit

class DataViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var dataLabel: UILabel!
    
    var dataObject: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        FBSDKProfile.enableUpdatesOnAccessTokenChange(true)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "onProfileUpdated:", name:FBSDKAccessTokenDidChangeNotification, object: nil)
        
        if (FBSDKAccessToken.currentAccessToken() == nil)
        {
            print("Not logged in..")
        }
        else
        {
            print("Logged in..")
            print("\(FBSDKAccessToken.currentAccessToken().userID)")
            print("\(FBSDKProfile.currentProfile().name)")

            //self.performSegueWithIdentifier("LoggedIn", sender: self)
        }
        
        let loginButton = FBSDKLoginButton()
        loginButton.readPermissions = ["public_profile", "email", "user_friends"]
        loginButton.center = self.view.center
        loginButton.delegate = self
        self.view.addSubview(loginButton)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.dataLabel!.text = dataObject
    }


    // MARK: - Facebook Login
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
        if error == nil
        {
            print("Login complete.")
            self.performSegueWithIdentifier("showFB_Login", sender: self)
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
    // in a LoginViewController.swift
    func onTokenUpdated(notification: NSNotification) {
        print(FBSDKProfile.currentProfile().name)
        if ((FBSDKAccessToken.currentAccessToken()) != nil) {
            print("token is not nil ")
        } else {
            print("token is nil")
        }
    }
    
}