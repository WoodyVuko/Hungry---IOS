//
//  FriendCell.swift
//  Hungry
//
//  Created by Goran Vukovic on 30.07.15.
//  Copyright © 2015 Goran Vukovic. All rights reserved.
//

import Foundation
import UIKit

class FriendCell: UITableViewCell
{
    @IBOutlet weak var picUser: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var food: UIImageView!
    
    @IBOutlet var label: UILabel!
    
    @IBOutlet weak var descrip: UILabel!
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.selectedBackgroundView = backgroundView
    }
}