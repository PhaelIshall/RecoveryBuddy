//
//  GoalViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/15/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

class GoalViewController: UIViewController {

    @IBOutlet weak var goalnameLabel: UILabel!
    @IBOutlet weak var goaltypeLabel: UILabel!

    @IBOutlet weak var progressLabel: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    
    
    
    var goalname, details: String?
    var goaltype, progress: Int?
    var startdate, endDate: NSDate?
    
    func setTime(){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        startDateLabel.text = formatter.stringFromDate(startdate!)
        endDateLabel.text = formatter.stringFromDate(startdate!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        goalnameLabel.text = goalname;
        goaltypeLabel.text = "\(goaltype!)"
        progressLabel.text = "\(progress!)% done"
        detailsLabel.text = details
        setTime()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
