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
    
    

     let user = User();
    
    func continuing() {
        
       
        user.username = username.text;
        user.password  = password.text;
        user.fullname = fullname.text!;
        user.email = email.text;
        user.age = Int(age.text!)!      
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "continueSignUp"){
            continuing()
            let secondView = segue.destinationViewController as! SignUp2ViewController
            secondView.user = user;
        }
        else{
            print("shut up");
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
