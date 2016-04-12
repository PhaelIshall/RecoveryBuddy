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
//    @IBOutlet weak var login
    
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
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "login"){
            if (checkIfValid()) {
                segue.destinationViewController as! HomeViewController
            }
        }
        else{
            segue.destinationViewController as! SignUpViewController
        }
            
        }
    
    
    func checkIfValid() -> Bool{
        var valid = false;
        let query = PFQuery(className: "User");
        query.whereKey("username", equalTo: username);
        query.whereKey("password", equalTo: password);
        query.findObjectsInBackgroundWithBlock({ (results, error) -> Void in
            if let results = results as? [PFUser] {
                valid = true;
            }
        })
        return valid
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
