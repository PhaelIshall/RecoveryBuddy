//
//  ViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 2/17/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

import Parse

class HomeViewController: UIViewController {

    @IBOutlet weak var partnerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true;

        //self.navigationController.navigationBar.tintColor = [UIColor lightGrayColor];
        // Do any additional setup after loading the view, typically from a nib.
       
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2;
        profilePicture.layer.borderWidth = 1;
        profilePicture.clipsToBounds = true;


        partnerImage.layer.cornerRadius = profilePicture.frame.size.width/4;
        partnerImage.layer.borderWidth = 1;
        partnerImage.clipsToBounds = true;

        if let user = PFUser.currentUser() {
//            var q = PFQuery(className: "User")
//            q.whereKey("objectId", equalTo: user.objectId!)
//            q.includeKey("partner")
//            q.getFirstObjectInBackgroundWithBlock({ (par, error) -> Void in
//                self.partner = par as! PFUser
//            })
//            
            name = user["fullName"] as! String
            age = user["age"] as! Int
            disorder = user["disorderType"] as! String
            email = user["email"] as! String
            //partner = user["partner"] as! PFUser
        }

    }
    
    

    var disorder = " ";
    var name = " "
    var email = " "
    var age: Int?
    var partner: PFUser?
    @IBOutlet weak var profilePicture: UIImageView!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goals"){
            segue.destinationViewController as! GoalsViewController
        }
        if (segue.identifier == "editProfile"){
        
            print(User.currentUser())
            
            let profile = segue.destinationViewController as! ProfileViewController
            profile.username = User.currentUser()?.username
            profile.fullname = name
            profile.age = "\(age!)"
            profile.disorderType = disorder
            profile.email = email
            profile.usernameOfPartner = partner?.username
        }
        
    }


}

