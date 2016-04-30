//
//  LoginViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/8/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    var valid: Bool = false

    @IBAction func login(sender: AnyObject) {
        do{
            try PFUser.logInWithUsername(username.text!, password: password.text!)
            if let currentUser = PFUser.currentUser() {
                print("\(currentUser.username!) logged in successfully")
                valid = true
                performSegueWithIdentifier("login", sender: self)
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
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGestureReconizer)
        username.delegate = self
        password.delegate = self
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
            _ = segue.destinationViewController as! SignUpViewController
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
 
    func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }


}
