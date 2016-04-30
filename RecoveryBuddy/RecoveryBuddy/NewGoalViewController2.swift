//
//  NewGoalViewController2.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/15/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

class NewGoalViewController2: UIViewController {

    @IBOutlet weak var endDate: UIDatePicker!
    @IBOutlet weak var startDate: UIDatePicker!
    var name : String?
    var details: String?
    var goalType : Int?
    var n: String?
    let goal = Goal()

    override func viewDidLoad() {
        super.viewDidLoad()
        goal.details = details!
        goal.goalType = goalType!
        goal.goalName = name!
        n = name
    }
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   
    @IBAction func doneSend(sender: AnyObject) {
        let d = done()
        if (d == true){
            self.presentingViewController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil)
        }
        else{
            let alertController = UIAlertController(title: "Cannot make goal", message: "The goal's start date is after the end date, or the duration of the goal is longer than 2 weeks", preferredStyle: .Alert)
            let callAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(callAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
        

    }
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

     func done() -> Bool{
        if (endDate.date.compare(startDate.date) == NSComparisonResult.OrderedDescending && startDate?.date.numberOfDaysUntilDateTime(endDate.date) < 14) {
            
            goal.progress = 0
            goal.startDate = startDate.date
            goal.endDate = endDate.date
            goal.belongsTo = User.currentUser()!
               print("\(n) + \(name)")
            goal.saveInBackgroundWithBlock(nil)
            return true
            
        }
        else{
            return false
        }
    }
    enum UIAlertControllerStyle : Int {
        case ActionSheet
        case Alert
    }
}
