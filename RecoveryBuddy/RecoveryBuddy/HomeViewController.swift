//
//  ViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 2/17/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2;
        profilePicture.layer.borderWidth = 1;
        profilePicture.clipsToBounds = true;
        

    }

    @IBOutlet weak var profilePicture: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goals"){
            segue.destinationViewController as! GoalsViewController
        }
    }


}

