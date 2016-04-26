//
//  GoalsCell.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/19/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

class GoalsCell: UITableViewCell {
 
    
    @IBOutlet weak var goalName: UILabel!

    
    @IBOutlet weak var type: UIView!{
        didSet{
            type.layer.borderColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha: 1.0).CGColor
            type.layer.borderWidth = 1.0
            type.layer.cornerRadius = 5
        }
    }
}
