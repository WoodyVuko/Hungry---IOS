//
//  SecondViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 13.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//


import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class SecondViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Button: UIButton!
    
    // TableView incl Array
    @IBOutlet var tableView: UITableView!
    var textArray: NSMutableArray! = NSMutableArray()

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true;
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        getCategoriesJSON()
        self.tableView.centerXAnchor
        self.tableView.reloadData()
    }
    
    // MARK: - GetJSON Categories
    
    func getCategoriesJSON()
    {
        RestApiManager.sharedInstance.getCategories
            {
                json -> Void in
                if let jsonArray = json.array
                {
                    //it is an array, each array contains a dictionary
                    for item in jsonArray
                    {
                        if let jsonDict = item.dictionary //jsonDict : [String : JSON]?
                        {
                            //loop through all objects in this jsonDictionary
                            let id = jsonDict["_id"]!.intValue
                            let catid = jsonDict["cat_id"]!.stringValue
                            let name = jsonDict["name"]!.stringValue
                            //...etc. ...create post object..etc.
                            // Übertragen via ASynch (Static/verschiedene Instanzen..)
                            dispatch_async(dispatch_get_main_queue(),
                                {
                                    textArray?.addObject(name)
                            })
                            
                            dispatch_async(dispatch_get_main_queue(),
                                {
                                    tableView?.reloadData()
                            })
                        }
                        
                        
                    }
                }
        }

    }
    
    func getRandomColor() -> UIColor{
        
        let randomRed:CGFloat = CGFloat(drand48())
        
        let randomGreen:CGFloat = CGFloat(drand48())
        
        let randomBlue:CGFloat = CGFloat(drand48())
        
        return UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
        
    }
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UITableViewDataSource

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Today i feel like..."

    }

    
    /*
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = UIColor(red: 0.967, green: 0.985, blue: 0.998, alpha: 1) // this example is a light blue, but of course it also works with UIColor.lightGrayColor()
    
        var header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.redColor()
        
    }
    */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(textArray.objectAtIndex(indexPath.row))
        
        self.dismissViewControllerAnimated(true, completion:nil)

        let next = self.storyboard?.instantiateViewControllerWithIdentifier("ThirdViewController") as! ThirdViewController
        next.chosenCategorie = textArray.objectAtIndex(indexPath.row) as! String
        self.presentViewController(next, animated: true, completion: nil)
    }
    


    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        
        cell!.textLabel?.text = self.textArray.objectAtIndex(indexPath.row) as? String
        cell!.textLabel?.textAlignment = .Center
        cell!.detailTextLabel?.textAlignment = .Center
        
        
        switch(indexPath.row)
        {
        case(0):
            cell!.backgroundColor = getRandomColor()
            break
        case(1):
            cell!.backgroundColor = getRandomColor()
            break
        case(2):
            cell!.backgroundColor = getRandomColor()
            break
        case(3):
            cell!.backgroundColor = getRandomColor()
            break
        case(4):
            cell!.backgroundColor = getRandomColor()
            break
        case(5):
            cell!.backgroundColor = getRandomColor()
            break
        case(6):
            cell!.backgroundColor = getRandomColor()
            break
        case(7):
            cell!.backgroundColor = getRandomColor()
            break
        case(8):
            cell!.backgroundColor = getRandomColor()
            break
        case(9):
            cell!.backgroundColor = getRandomColor()
            break
        case(10):
            cell!.backgroundColor = getRandomColor()
            break
        case(11):
            cell!.backgroundColor = getRandomColor()
            break
        case(12):
            cell!.backgroundColor = getRandomColor()
            break
        case(13):
            cell!.backgroundColor = getRandomColor()
            break
        case(14):
            cell!.backgroundColor = getRandomColor()
            break
        case(15):
            cell!.backgroundColor = getRandomColor()
            break
        case(16):
            cell!.backgroundColor = getRandomColor()
            break
        case(17):
            cell!.backgroundColor = getRandomColor()
            break
        case(18):
            cell!.backgroundColor = getRandomColor()
            break
        default:
            cell!.backgroundColor = getRandomColor()
            break
            
        }
        
        return cell!
    }
    
}


