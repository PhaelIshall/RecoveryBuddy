//
//  GoalsViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 3/14/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class GoalsViewController: UIViewController {



    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        retrieveGoals();
        tableview.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.delegate = self;
            tableview.dataSource = self;
        }
    }
    var retrievedGoals = [Goal]();
    
    func retrieveGoals(){
        let query = PFQuery(className: "Goal");
        //query.whereKey("belongTo", equalTo: (User.currentUser()?.objectId)!);
        query.findObjectsInBackgroundWithBlock({
            (goals, error) -> Void in
            
            if let g = goals as? [Goal]{
                for entry in g{
                    self.retrievedGoals.append(entry);
                }
                self.tableview.reloadData();
            }
            else {
                print(error)
            }
        })
        
        
        print(retrievedGoals.capacity)
    }
    
    
    var selectedGoal: Goal?
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "openReq"){
            let nav = segue.destinationViewController as! NavigationController
            let openGoal = nav.topViewController as! GoalViewController
            
            
            var indexPath = self.tableview.indexPathForSelectedRow!
             selectedGoal = retrievedGoals[indexPath.item]
           openGoal.details = selectedGoal?.details
            openGoal.progress = selectedGoal?.progress

            openGoal.goalname = selectedGoal?.goalName
           openGoal.goaltype = selectedGoal?.goalType
            openGoal.startdate = selectedGoal?.startDate
            openGoal.endDate = selectedGoal?.endDate
        }
    }
    
}


//var array;

extension GoalsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrievedGoals.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath) as! GoalsCell
        selectedGoal = retrievedGoals[indexPath.item]
        cell.goalName.text = retrievedGoals[indexPath.item].goalName;
        cell.goalProgress.text = "You are \(retrievedGoals[indexPath.item].progress) done.";
        cell.textLabel?.text = retrievedGoals[indexPath.item].goalName;
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //selectedGoal = retrievedGoals[indexPath.item]
        //self.performSegueWithIdentifier("openReq", sender: self)
    }
}
