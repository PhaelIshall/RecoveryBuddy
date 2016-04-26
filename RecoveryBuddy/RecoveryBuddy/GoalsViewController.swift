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

    var partnerGoals: Bool?
    var userSelected = User.currentUser()
    
    @IBOutlet weak var add: UIBarButtonItem!
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var milestonesSelected = false
    @IBAction func indexChanegd(sender: AnyObject) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            retrieveGoals();
            milestonesSelected = false
            retrievedGoals = []
            print("goals")
        case 1:
            retrievedGoals = []
            milestonesSelected = true
            retrieveMilestones()
            tableview.reloadData()
            retrievedGoals = []
      print("milestones")
        default:
            break;
        }

    }
    
    override func viewWillAppear(animated: Bool) {
        retrievedGoals = []

        if (partnerGoals != nil){
            self.navigationItem.rightBarButtonItem = nil;
            let partnerQuery = PFQuery(className: "Partner")
            partnerQuery.whereKey("fromUser", equalTo: User.currentUser()!)
            
            let p = User.query()
            //postsFromPartner?.whereKey("user", equalTo: User.currentUser()!)
            p?.whereKey("partner", matchesKey: "fromUser", inQuery: partnerQuery)
            
            
            p?.findObjectsInBackgroundWithBlock({ (p, error) -> Void in
                if let partner = p as? [User] {
                    for entry in partner{
                        if (entry != User.currentUser()){
                            self.userSelected = entry
                            print("PARTNER \(entry)")
                            
                        }
                        
                        
                    }
                }
                
                self.retrieveGoals();
                self.tableview.reloadData()
         
            })
            
        }
        else{
            
            retrieveGoals();
            tableview.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       

        
        // Do any additional setup after loading the view.
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
        if (userSelected == nil){
                userSelected = User.currentUser()
        }
        print(userSelected)
        let query = PFQuery(className: "Goal");
        
        query.whereKey("belongsTo", equalTo: userSelected!);
        
          query.whereKey("progress", notEqualTo: 100)
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
    @IBAction func presentAdd(sender: AnyObject) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("newGoal") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    func retrieveMilestones(){
        let query = PFQuery(className: "Goal");
        query.whereKey("belongsTo", equalTo: userSelected!);
        query.whereKey("progress", equalTo: 100);
        
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
            
            openGoal.goalId = selectedGoal?.objectId!
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
        if (selectedGoal?.goalType == 0){
            cell.type.backgroundColor = UIColor(red: 211/255, green: 206/255, blue: 171/255, alpha: 1.0)
           
        }
        else if (selectedGoal?.goalType == 1){
            cell.type.backgroundColor = UIColor(red: 52/255, green: 154/255, blue: 87/255, alpha: 1.0)
          
        }
        else if (selectedGoal?.goalType == 2){
            cell.type.backgroundColor = UIColor(red: 211/255, green: 93/255, blue: 71/255, alpha: 1.0)
       
        }
        else if (selectedGoal?.goalType == 3){
            cell.type.backgroundColor = UIColor(red: 121/255, green: 54/255, blue: 142/255, alpha: 1.0)
        }
        else{
            cell.type.backgroundColor = UIColor(red: 53/255, green: 94/255, blue: 137/255, alpha: 1.0)
        
        }
        cell.goalName.text = retrievedGoals[indexPath.item].goalName;
        //cell.goalProgress.text = "You are \(retrievedGoals[indexPath.item].progress) done.";
        //cell.textLabel?.text = retrievedGoals[indexPath.item].goalName;
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //selectedGoal = retrievedGoals[indexPath.item]
        //self.performSegueWithIdentifier("openReq", sender: self)
    }
}
