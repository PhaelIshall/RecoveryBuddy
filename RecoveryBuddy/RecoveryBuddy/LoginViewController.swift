//
//  LoginViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/8/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var valid: Bool = false

    @IBAction func login(sender: AnyObject) {
        do{
              print("\(username.text!) \(password.text!)")
            try PFUser.logInWithUsername(username.text!, password: password.text!)
            if let currentUser = PFUser.currentUser() {
                print("\(currentUser.username!) logged in successfully")
                valid = true
            } else {
                print("No logged in user :(")
            }
        }
        catch{
        }
    }
    
    
    
    @IBAction func SignUpClicked(sender: AnyObject) {
        self.performSegueWithIdentifier("signUp", sender: self)
    }
    
    @IBOutlet weak var signUp: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "login"){
            if (valid){
                segue.destinationViewController as! UITabBarController
            }
        }
        else{
            segue.destinationViewController as! SignUpViewController
        }
            
    }


}
