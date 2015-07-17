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
                // Finde Key cCategories"
                let tmp:Dictionary  = json["categories"].dictionaryValue
                // Durchsuche Dictionary nach Inhalt
                for dict in tmp
                {
                    // Übertragen via ASynch (Static/verschiedene Instanzen..)
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            textArray?.addObject(dict.1.string!)
                        })
                
                    dispatch_async(dispatch_get_main_queue(),
                        {
                            tableView?.reloadData()
                        })
                }
            }
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
            cell!.backgroundColor = UIColor.orangeColor()
            break
        case(1):
            cell!.backgroundColor = UIColor.redColor()
            break
        case(2):
            cell!.backgroundColor = UIColor.blueColor()
            break
        case(3):
            cell!.backgroundColor = UIColor.yellowColor()
            break
            
        default:
            cell!.backgroundColor = UIColor.whiteColor()

            break
            
        }
        
        return cell!
    }
    
}


