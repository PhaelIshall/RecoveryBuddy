//
//  DayViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/26/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class DayViewController: UIViewController {

    @IBOutlet weak var mySwitch: UISwitch!
    var goalType: String?
    var exists: Bool?
    @IBOutlet weak var dayNumber: UILabel!
    var day = "Day"
    var goal: String?
    var days: [String] = []
    var success: Bool?
    var q1,q2,q3: String?
    @IBOutlet weak var question3: UITextField!
    @IBOutlet weak var question2: UITextField!
    @IBOutlet weak var question1: UITextField!
  
    
    var selectedDay: PFObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        dayNumber?.text = day
    
        // Do any additional setup after loading the view.
    }
   
    
    @IBAction func pressedDone(sender: AnyObject) {
        selectedDay.setObject(self.question1.text!, forKey: "q1")
        selectedDay.setObject(self.question2.text!, forKey: "q2")
        selectedDay.setObject(self.question3.text!, forKey: "q3")
        selectedDay.setObject(goal!, forKey: "goal")
        selectedDay.setObject(User.currentUser()!, forKey: "user")
        selectedDay.setObject(self.success!, forKey: "success")
        selectedDay.setObject(self.day , forKey: "dayNumber")
        selectedDay.saveInBackground()
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            success = true
            mySwitch.setOn(true, animated:true)
        } else {
            success = false
            mySwitch.setOn(false, animated:true)
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        if (selectedDay["user"] as! User != User.currentUser()){
            self.navigationItem.rightBarButtonItem?.enabled = false
        }
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGestureReconizer)
    
            question1.text = selectedDay!["q1"] as? String
            question2.text = selectedDay!["q2"] as? String
            question3.text = selectedDay!["q3"] as? String
            success = selectedDay["success"] as? Bool ?? true
            mySwitch.setOn(success!, animated: true)
        
       
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
