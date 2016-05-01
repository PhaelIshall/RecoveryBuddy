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
    
    

    @IBOutlet weak var goalnameLabel: UITextField!
    @IBOutlet weak var goaltypeLabel: UITextField!
    @IBOutlet weak var progressLabel:UITextField!
    @IBOutlet weak var detailsLabel: UITextView!
    @IBOutlet weak var endDateLabel:UITextField!
    @IBOutlet weak var startDateLabel: UITextField!
    
    
    @IBAction func back(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    var goalId: String?
    var dictionaryOfDays = [String: PFObject]()
    var goalname, details: String?
    var goaltype, progress: Int?
    var startdate, endDate: NSDate?
    var dateDifference: Int?
    var selectedDay: String?
    var user: User?
    
    func setTime(){
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        startDateLabel.text = formatter.stringFromDate(startdate!)
        endDateLabel.text = formatter.stringFromDate(endDate!)
    }
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        dateDifference = startdate?.numberOfDaysUntilDateTime(endDate!)
        for i in 0...dateDifference!{
            dictionaryOfDays["Day \(i)"] = PFObject(className: "Days")
        }
        navigationItem.hidesBackButton = true;
        setTime()
        goalnameLabel.text = goalname;
        goaltypeLabel.text = GoalType.getType(goaltype!)
        detailsLabel.text = details
        progressLabel.text = "\(progress!)% done"
        
        let q = PFQuery(className: "Days")
        q.whereKey("goal", equalTo: goalId!)
        q.findObjectsInBackgroundWithBlock { (result, error) -> Void in
        
            if(error == nil)
            {
                for r in result! {
                    self.dictionaryOfDays[(r["dayNumber"] as? String)!] = r
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func viewDidAppear(animated: Bool) {
     
        goalnameLabel.enabled = false
        goaltypeLabel.enabled = false
        progressLabel.enabled = false
        detailsLabel.editable = false
        startDateLabel.enabled = false
        endDateLabel.enabled = false
        
      
        let currentDate = NSDate()
        dateDifferenceFromNow = startdate?.numberOfDaysUntilDateTime(currentDate)
        tableview.reloadData()

    }
    var dateDifferenceFromNow: Int?
    
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
                dayController.day = "Day \(indexPath.item)"
                dayController.goal = goalId!

            dayController.selectedDay = dictionaryOfDays["Day \(indexPath.item)"]
            dayController.user = user
    
        }
    }
    
    


}
extension GoalViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dictionaryOfDays.count
        }
    
    
    
        
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("daysCell", forIndexPath: indexPath)
       selectedDay =  "Day \(indexPath.item)"
        cell.textLabel?.text = selectedDay
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if (indexPath.item > dateDifferenceFromNow){
            return nil
        }
        return indexPath
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
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




