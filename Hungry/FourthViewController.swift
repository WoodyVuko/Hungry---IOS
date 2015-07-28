//
//  SecondViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 13.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//


import UIKit

class FourthViewController: UIViewController, UITableViewDataSource, UITableViewDelegate
{
    @IBOutlet weak var Name: UILabel!
    @IBOutlet weak var Button: UIButton!
    
    // TableView incl Array
    @IBOutlet var tableView: UITableView!
    var dicti : NSDictionary = PlistManager.defaultManager.readPlist("Favoriten")!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print(PlistManager.defaultManager.readPlist("Favoriten"))
        print(dicti)
        
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
    
    
    @IBAction func showSidebar(sender: AnyObject)
    {
        let next = self.storyboard?.instantiateViewControllerWithIdentifier("FilterViewController") as! FilterViewController
        self.navigationController!.pushViewController(next, animated: true)
    }
    
    // MARK: - UITableViewDataSource

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //return "Today i feel like..."
        return nil

    }

    
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        view.tintColor = UIColor(red: 0.967, green: 0.985, blue: 0.998, alpha: 1) // this example is a light blue, but of course it also works with UIColor.lightGrayColor()
    
        var header : UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel!.textColor = UIColor.redColor()
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print(self.dicti["Title"]!.objectAtIndex(indexPath.row) as? String)
        
    }
    


    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell? = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell?
        
        cell!.textLabel?.text = self.dicti["Title"]!.objectAtIndex(indexPath.row) as? String
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


