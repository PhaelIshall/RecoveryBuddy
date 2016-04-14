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
   
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    
    

    
    
    @IBAction func continuing(sender: AnyObject) {
        let user = User();
        user.username = username.text;
        user.password  = password.text;
        user.fullname = fullname.text!;
        user.email = email.text;
        //user["age"] = userAge;
        //user["email"] = userEmail;
        
        user.signUpInBackgroundWithBlock{ (succeeded: Bool, error: NSError?) -> Void in
        if let error = error {
            _ = error.userInfo["error"] as? NSString
            // Show the errorString somewhere and let the user try again.
        } else {
            // Hooray! Let them use the app now.
        }
        
        
        }
        self.performSegueWithIdentifier("continueSignUp", sender: self)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "continueSignUp"){
            segue.destinationViewController as! SignUp2ViewController
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
