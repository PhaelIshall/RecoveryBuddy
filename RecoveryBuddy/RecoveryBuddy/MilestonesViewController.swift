//
//  MilestonesViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 3/14/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class MilestonesViewController: UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        retrieveMilestones();
        tableview.reloadData()
        
    }
    @IBOutlet weak var tableview: UITableView!{
        didSet{
            tableview.delegate = self;
            tableview.dataSource = self;
        }
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var retrievedMilestones = [Goal]();
    
    func retrieveMilestones(){
        let query = PFQuery(className: "Goal");
        query.whereKey("belongsTo", equalTo: (User.currentUser())!);
        query.whereKey("progress", equalTo: 100);
        
        query.findObjectsInBackgroundWithBlock({
            (goals, error) -> Void in
            
            if let g = goals as? [Goal]{
                for entry in g{
                    self.retrievedMilestones.append(entry);
                }
                self.tableview.reloadData();
            }
            else {
                print(error)
            }
        })
        
        
        print(retrievedMilestones.capacity)
    }
    
    
}


//var array;

extension MilestonesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrievedMilestones.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath)
        cell.textLabel?.text = retrievedMilestones[indexPath.item].goalName;
        return cell
    }
}

