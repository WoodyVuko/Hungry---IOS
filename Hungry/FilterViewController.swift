//
//  FilterViewController.swift
//  Hungry
//
//  Created by Goran Vukovic on 24.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import Foundation
import UIKit

class FilterViewController: UIViewController
{
    @IBOutlet weak var distanceSlide: UISlider!
    @IBOutlet weak var priceSlide: UISlider!
    @IBOutlet weak var distance: UILabel!
    @IBOutlet weak var price: UILabel!
    
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
        distance.text = String(Int(ThirdViewController.distance))
        distanceSlide.value = Float(ThirdViewController.distance)
        
    }

}