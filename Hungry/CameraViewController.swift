//
//  ThirdViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 15.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//


import UIKit

class CameraViewController: UIViewController
{
    //@IBOutlet weak var Button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var desc: UITextField!
    var croppingEnabled: Bool = true
    var img : NSData = NSData()
    var tmp : JSONData = JSONData();
    var checkPic : Bool = false
    var checkDesc : Bool = false

    @IBOutlet weak var wait: UILabel!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        activity.alpha = 0
        
        if((checkDesc == true) && (checkPic == true))
        {
            uploadButton.enabled = true
        }
        else
        {
            uploadButton.enabled = false

        }
        
        // Keyboard Movement on Click
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        
        // prevents the scroll view from swallowing up the touch event of child buttons
        tapGesture.cancelsTouchesInView = false
        
        scrollView.addGestureRecognizer(tapGesture)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.registerForKeyboardNotifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.deregisterFromKeyboardNotifications()
        super.viewWillDisappear(true)
        
    }
    
    // - Mark Keyboard
    func registerForKeyboardNotifications() -> Void {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillShowNotification, object: nil)
        
    }
    
    func deregisterFromKeyboardNotifications() -> Void {
        print("Deregistering!")
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardDidHideNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWasShown:", name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWasShown(notification: NSNotification) {
        var info: Dictionary = notification.userInfo!
        let keyboardSize: CGSize = (info[UIKeyboardFrameBeginUserInfoKey]?.CGRectValue.size)!
        let buttonOrigin: CGPoint = self.uploadButton.frame.origin;
        let buttonHeight: CGFloat = self.uploadButton.frame.size.height;
        var visibleRect: CGRect = self.view.frame
        visibleRect.size.height -= keyboardSize.height
        
        if (!CGRectContainsPoint(visibleRect, buttonOrigin)) {
            let scrollPoint: CGPoint = CGPointMake(0.0, buttonOrigin.y - visibleRect.size.height + buttonHeight + 4)
            self.scrollView.setContentOffset(scrollPoint, animated: true)
            
        }
    }
    
    func hideKeyboard() {
           //FirstResponder's must be resigned for hiding keyboard.
        self.desc.resignFirstResponder()
        self.scrollView.setContentOffset(CGPointZero, animated: true)
        
        self.scrollView.resignFirstResponder()
        self.uploadButton.enabled = true

    }
    
    // -Mark Keyboard End
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickDescription(sender: AnyObject)
    {
        self.uploadButton.enabled = true
    }
    
    @IBAction func openCamera(sender: AnyObject) {
        
        let cameraViewController = ALCameraViewController(croppingEnabled: croppingEnabled) { (image) -> Void in
            self.imageView.image = image
            self.img = UIImagePNGRepresentation(self.imageView.image!)!

            self.dismissViewControllerAnimated(true, completion: nil)
            
        }
        
        presentViewController(cameraViewController, animated: true, completion: nil)
        
        checkPic = true
    }
    
func uploadFunction()
{
    let myUrl: String = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/addimage"
    
    
    let param = [
        "username" : "hangry",
        "password" : "a8JwAkBy",
        "fb_id" : String(ViewController.fbID),
        "place_id" : String(tmp.getID()),
        "img_description" : String(desc!.text!)
    ]
    
    //  talk to registration end point
    let r = Just.post(
        myUrl,
        data: param,
        
        files: [
            "file":HTTPFile.Data("Image.png", img, "multipart/form-data")
        ]
    )
    
    if (r.ok)
    {
        print("Picture was Uploaded")
        self.activity.stopAnimating()
        self.activity.alpha = 0
        self.imageView.image = UIImage(contentsOfFile: "ALPlaceholder.png")
        self.desc.text = ""
        
    }
}
    @IBAction func Upload(sender: AnyObject)
    {
        self.activity.startAnimating()
        self.activity.alpha = 1.0
        let timer = NSTimer.scheduledTimerWithTimeInterval(0.8, target: self, selector: Selector("uploadFunction"), userInfo: nil, repeats: false);

        NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
    }
    
    @IBAction func done(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

