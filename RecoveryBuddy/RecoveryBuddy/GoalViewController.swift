//
//  GoalViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/15/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class GoalViewController: UIViewController {
    
    var goalId: String?

    @IBOutlet weak var goalnameLabel: UITextField!
    @IBOutlet weak var goaltypeLabel: UITextField!

    @IBOutlet weak var progressLabel:UITextField!
    @IBOutlet weak var detailsLabel: UITextView!
    @IBOutlet weak var endDateLabel:UITextField!
    @IBOutlet weak var startDateLabel: UITextField!
    
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
 
    var goalname, details: String?
    var goaltype, progress: Int?
    var startdate, endDate: NSDate?
    
    @IBAction func update(sender: AnyObject) {
    
    
    }
    
    func setTime(){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        startDateLabel.text = formatter.stringFromDate(startdate!)
        endDateLabel.text = formatter.stringFromDate(endDate!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true;
        setTime()
        goalnameLabel.text = goalname;
        goaltypeLabel.text = GoalType.getType(goaltype!)
        print(dateDifferenceFromNow)
        print(dateDifference)
        
        detailsLabel.text = details
    
        progressLabel.text = "\(progress!)% done"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var dateDifference: Int?
    
    override func viewDidAppear(animated: Bool) {
        goalnameLabel.enabled = false
        goaltypeLabel.enabled = false
        progressLabel.enabled = false
        detailsLabel.editable = false
        startDateLabel.enabled = false
        endDateLabel.enabled = false
        
        dateDifference = startdate?.numberOfDaysUntilDateTime(endDate!)
        for i in 0...dateDifference!{
            days.append("Day \(i)")
        }
        let currentDate = NSDate()
        dateDifferenceFromNow = startdate?.numberOfDaysUntilDateTime(currentDate)
        

        
        
        tableview.reloadData()

    }
    var dateDifferenceFromNow: Int?
    
    var days: [String] = []
    
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.delegate = self;
            tableview.dataSource = self;
            
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "openDay"){
            let indexPath = self.tableview.indexPathForSelectedRow!
     
                let dayController = segue.destinationViewController as! DayViewController
                dayController.exists = false
                dayController.day = days[indexPath.item]
                dayController.goal = goalId!
                let q = PFQuery(className: "Days")
                q.whereKey("dayNumber", equalTo: days[indexPath.item])
                q.whereKey("goal", equalTo: goalId!)
                //q.whereKey("user", equalTo: User.currentUser()!)
                q.findObjectsInBackgroundWithBlock { (result, error) -> Void in
                    
                    for p in result! {
                        dayController.q1 = p["q1"] as? String
                        dayController.q2 = p["q2"] as? String
                        dayController.q3 = p["q3"] as? String
                        dayController.exists = true
                        print(p)
                    }
                }
           
            
        }
    }
    
    
var selectedDay: String?

}
extension GoalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return days.count
        }
    
    
    
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("daysCell", forIndexPath: indexPath)
       selectedDay = days[indexPath.item]
        cell.textLabel?.text = selectedDay
        print(indexPath.item)
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        //cell.goalProgress.text = "You are \(retrievedGoals[indexPath.item].progress) done.";
        //cell.textLabel?.text = retrievedGoals[indexPath.item].goalName;
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if (indexPath.item > dateDifferenceFromNow){
            return nil
        }
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
      //  self.performSegueWithIdentifier("openDay", sender: self)
    }
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.item > dateDifferenceFromNow){
            cell.backgroundColor = UIColor(red: 206/255, green: 206/255, blue: 206/255, alpha: 1)
        }
    }

        
}
    
extension NSDate {
    func numberOfDaysUntilDateTime(toDateTime: NSDate, inTimeZone timeZone: NSTimeZone? = nil) -> Int {
        let calendar = NSCalendar.currentCalendar()
        if let timeZone = timeZone {
            calendar.timeZone = timeZone
        }
        
        var fromDate: NSDate?, toDate: NSDate?
        
        calendar.rangeOfUnit(.Day, startDate: &fromDate, interval: nil, forDate: self)
        calendar.rangeOfUnit(.Day, startDate: &toDate, interval: nil, forDate: toDateTime)
        
        let difference = calendar.components(.Day, fromDate: fromDate!, toDate: toDate!, options: [])
        return difference.day
    }
}




