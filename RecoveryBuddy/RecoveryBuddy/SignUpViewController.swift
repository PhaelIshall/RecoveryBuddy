//
//  SignUpViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 3/21/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController{
   
    @IBOutlet weak var fullname: UITextField!

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var age: UITextField!
   
    @IBAction func continuing(sender: AnyObject) {
        var user = PFUser();
        user["username"] = userName;
        user["password"] = userPassword;
        user["fullName"] = fullName;
        user["age"] = userAge;
        user["email"] = userEmail;
        
        user.saveInBackgroundWithBlock(nil);
        
        
        
    }
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    var fullName: NSString = "";
    var userName: NSString = "";
    var userAge: NSString = "";
    var userPassword: NSString = "";
    var userEmail: NSString = "" ;
    
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
