//
//  NewGoalViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/14/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

class NewGoalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var addDetails: UITextView!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func createGoal(){
        let goal = Goal();
        goal.goalType = 
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
