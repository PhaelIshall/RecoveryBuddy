//
//  DayViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/26/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

class DayViewController: UIViewController {

    @IBOutlet weak var `switch`: UISwitch!
    var goalType: String?
    
    
    @IBOutlet weak var dayNumber: UILabel!
    var day = "Day"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dayNumber?.text = day
    
        // Do any additional setup after loading the view.
    }

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
