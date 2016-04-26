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
    
    
    var profilePicture: NSData?
    
     var photoTakingHelper: PhotoTakingHelper?
    @IBAction func uploadPic(sender: AnyObject) {
        photoTakingHelper = PhotoTakingHelper(viewController: self, successCallback: { (image: UIImage?) in
            print("received a callback")
            if let image = image {
                let imageData = UIImageJPEGRepresentation(image, 0.8)!
                
                    self.profilePicture = imageData
            }
  
        })
    
    }

     let user = User();
    
    func continuing() {
        
       
        user.username = username.text;
        user.password  = password.text;
        user.fullname = fullname.text!;
        user.email = email.text;
        if let a = Int(age.text!){
            user.age = a
        }
        else{
           user.age = 0 
        }
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "continueSignUp"){
            continuing()
            let secondView = segue.destinationViewController as! SignUp2ViewController
            secondView.user = user;
            secondView.profilePic = profilePicture
        }
        else{
            print("shut up");
        }
    }
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGestureReconizer)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    
    func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    

}
