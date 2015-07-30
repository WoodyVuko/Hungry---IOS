//
//  FriendViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 30.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import Foundation

//
//  SecondViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 13.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//


import UIKit


import UIKit

extension UIImage {
    var rounded: UIImage {
        let imageView = UIImageView(image: self)
        imageView.layer.cornerRadius = size.height < size.width ? size.height/2 : size.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
    var circle: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.renderInContext(UIGraphicsGetCurrentContext())
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result
    }
}

class FriendViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    
    @IBOutlet var tableView: UITableView!
    var data: NSData?

    var friendFeed : [FriendClass] = [FriendClass]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        let myUrl: String = "http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com:8080/friendsfeed"
        
        //let friendList = ["923425457696888", "1031399060211848", "960043157349260"]
        
        let param = [
            "password" : "a8JwAkBy",
            "username" : "hangry",
            "fb_id" : "1031399060211848",
            "friends" : ["923425457696888", "960043157349260"]
        ]
        
        let r = Just.post(myUrl, json: param )
        
        if (r.ok)
        {
            // Return Server
            let tmp = r.json
            
            let image = tmp!["images"] as! [[String : AnyObject]]
            for images in image
            {
                let tmp : FriendClass = FriendClass()

                let image_des = images["image_description"]!
                let img_url = images["image_url"]!
                let fbid = images["fb_id"]
                let timestamp = images["timestamp"]
                
                tmp.loadIn(String(fbid), images: String("http://ec2-52-28-74-34.eu-central-1.compute.amazonaws.com/images/") + String(img_url), description: String(image_des), time: String(timestamp))
                    
                friendFeed.append(tmp)
            }
        }
        
    }
    
    
    override func viewDidAppear(animated: Bool)
    {
        print(friendFeed.count)
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDataSource
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return friendFeed.count
        return 5
}

    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "Today i feel like..."
        return nil
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print(nameCategories.objectAtIndex(indexPath.row))
        
      /*
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController
        ThirdViewController.chosenCategorie = idCategories.objectAtIndex(indexPath.row) as! String
        /* self.presentViewController(next, animated: true, completion: nil)
        */
        self.navigationController!.pushViewController(next, animated: true)
        */
    }
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: FriendCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as! FriendCell
        //tableView.estimatedRowHeight = 200.0
        tableView.rowHeight = 320
        
       /* cell!.textLabel?.text = self.friendFeed[indexPath.row].getDescription() as? String
        cell!.textLabel?.textAlignment = .Center
        cell!.detailTextLabel?.textAlignment = .Center
        */
        
        cell.descrip.text = self.friendFeed[indexPath.row].getDescription()
        
        for(var i : Int = 0; i < ViewController.fbinfo.count; i++)
        {
            if(friendFeed[indexPath.row].getID() == "Optional(" + String(ViewController.fbinfo[i].getID()) + ")")
            {
                // Name
                cell.nameUser.text = ViewController.fbinfo[i].getName()
                
                // Icon
                let u = String("http://graph.facebook.com/" + String(ViewController.fbinfo[i].getID()) + "/picture?width=50&height=50&redirect=false")
                let x = Just.get(u)
                let xx = x.json
                let ra = xx!.valueForKeyPath("data")  as! [String : AnyObject]
                let raa = ra["url"]
                let url = NSURL(string: String(raa!))
                data = NSData(contentsOfURL:url!)
                
                let img = UIImage(data:data!)

                if data != nil {
                    cell.picUser.image  = img?.circle
            }
                
                //Pics
                let tmp = friendFeed[indexPath.row].getImages()
                let tmp2 = NSURL(string: String(tmp))
                data = NSData(contentsOfURL:tmp2!)
                
                if data != nil {
                    cell.food.image = UIImage(data:data!)
                }
                
        }
        
        
        }
        
        
        return cell
    }

    @IBAction func showSidebar(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("FilterViewController") as! FilterViewController
        self.navigationController!.pushViewController(next, animated: true)
    }



    
    
}