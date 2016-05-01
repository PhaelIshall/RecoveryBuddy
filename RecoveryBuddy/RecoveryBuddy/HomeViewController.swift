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


    @IBOutlet weak var username: UILabel!

    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.rightBarButtonItem!.enabled = false; //This is because Edit profile is not done yet
        if let pic = pic{
            profilePicture.image = UIImage(data: pic)
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true;
        profilePicture.layer.cornerRadius = profilePicture.frame.size.width/2;
        profilePicture.layer.borderWidth = 1;
        profilePicture.clipsToBounds = true;
        if let user = PFUser.currentUser() {
            name = user["fullName"] as! String
            age = user["age"] as? Int
            disorder = user["disorderType"] as! String
            email = user["email"] as! String
            do{
                let img = user["profilePic"] as! PFFile
                username.text = User.currentUser()?.username
                try self.pic = img.getData()
                try profilePicture.image = UIImage(data: img.getData())
                }
            catch{
            }
        }
    }



    var disorder: String!;
    var name: String!
    var email: String!
    var age: Int!
    var partner: PFUser?
    var pic: NSData?
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
    let profile = segue.destinationViewController as! ProfileViewController
            profile.username = User.currentUser()!.username
            profile.fullname = name
            profile.age = "\(age)"
            profile.disorderType = disorder
            profile.email = email
            profile.usernameOfPartner = partner?.username
            profile.imageData = pic
        }
        
    }


}

