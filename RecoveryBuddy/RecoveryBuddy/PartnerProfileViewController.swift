//
//  MilestonesViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 3/14/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class PartnerProfileViewController: UIViewController{
    
    @IBOutlet weak var partnerPic: UIImageView!
    
    var partnerPicData: NSData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
    
    override func viewDidAppear(animated: Bool) {
        if (partnerPicData != nil){
            partnerPic.image = UIImage(data: partnerPicData!)
        }
        
    }
}