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
    
    @IBOutlet var tableView: UITableView!
    
    var textArray: NSMutableArray! = NSMutableArray()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.textArray.addObject("Erstens")
        self.textArray.addObject("Zweiter")
        self.textArray.addObject("Dritter")
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 44.0
        
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        
        cell!.textLabel?.text = self.textArray.objectAtIndex(indexPath.row) as? String
        
        return cell!
    }
    
}


