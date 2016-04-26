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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mySwitch.addTarget(self, action: Selector("stateChanged:"), forControlEvents: UIControlEvents.ValueChanged)
        dayNumber?.text = day
    
        // Do any additional setup after loading the view.
    }
    var goal: String?
    var days: [String] = []
    
    @IBAction func pressedDone(sender: AnyObject) {
        
        print(self.goal)
        if (question1.text != q1 || question1.text != q2 || question1.text != q3){
            let q = PFQuery(className: "Days")
            q.whereKey("dayNumber", equalTo: dayNumber.text!)
            q.whereKey("goal", equalTo: goal!)
            //q.whereKey("user", equalTo: User.currentUser()!)
            q.findObjectsInBackgroundWithBlock { (result, error) -> Void in
                
                for p in result! {
                    p["q1"] = self.question1.text!
                    p.setObject(self.question2.text!, forKey: "q2")
                    p.setObject(self.question3.text!, forKey: "q3")
                    p.saveInBackground()
                }
                
            }
        }
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    var success: Bool?
    func stateChanged(switchState: UISwitch) {
        if switchState.on {
            success = true
        } else {
            success = false
        }
    }
    
    
    override func viewDidAppear(animated: Bool) {
        let tapGestureReconizer = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGestureReconizer)
        print(goal)
        if (exists == true){
            question1.text = q1
            question2.text = q2
            question3.text = q3
        }
        else{
            let newDay = PFObject(className: "Days")
            newDay["success"] = true
            newDay["dayNumber"] = dayNumber.text
            newDay["goal"] = goal!
            newDay["user"] = User.currentUser()
            newDay.saveInBackground()

        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
        
    }
    
    
    func tap(sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    
    
    
    var q1,q2,q3: String?
    @IBOutlet weak var question3: UITextField!
    @IBOutlet weak var question2: UITextField!
    @IBOutlet weak var question1: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
