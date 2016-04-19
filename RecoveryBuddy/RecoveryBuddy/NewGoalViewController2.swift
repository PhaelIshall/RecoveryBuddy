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
    override func viewDidLoad() {
        super.viewDidLoad()
        goal.details = details!
        goal.goalType = goalType!
        goal.goalName = name!
        n = name
            print("\(n) + \(name)")
        // Do any additional setup after loading the view.
    }
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    let goal = Goal()
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "goBackToGoals" ){
//            let tabBarController = segue.destinationViewController as! UITabBarController;
//            let destinationViewController = tabBarController.viewControllers![1] as! NavigationController
//            let barViewControllers = segue.destinationViewController as! UITabBarController
//            let nav = barViewControllers.viewControllers![1] as! UINavigationController
//            let destinationViewController = nav.topViewController as! GoalsViewController
           segue.destinationViewController as! UITabBarController
            
            done()
        }
    }
    
     func done() {
        if (endDate.date.compare(startDate.date) == NSComparisonResult.OrderedDescending) {
            
            goal.progress = 0
            goal.startDate = startDate.date
            goal.endDate = endDate.date
            goal.belongsTo = User.currentUser()!
               print("\(n) + \(name)")
            goal.saveInBackgroundWithBlock(nil)
        }
        else{
            
            print("Goal not saved")
//            let alertController = UIAlertController(title: "Hey AppCoda", message: "What do you want to do?", preferredStyle: .Alert)
//            let callAction = UIAlertAction(title: "Call", style: .Default, handler: {
//                action in
//                let alertMessage = UIAlertController(title: "Service Unavailable", message: "Sorry, the call feature is not available yet. Please retry later.", preferredStyle: .Alert)
//                alertMessage.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
//                self.presentViewController(alertMessage, animated: true, completion: nil)
//                }
//            )
//            alertController.addAction(callAction)
        }
    }
    enum UIAlertControllerStyle : Int {
        case ActionSheet
        case Alert
    }
}
