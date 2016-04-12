//
//  GoalsViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 3/14/16.
//  Copyright (c) 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit

class GoalsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableview.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var tableview: UITableView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//var array;
let myarray = ["Meal Plan", "Exercise ", "Meal Plan 2"]
extension GoalsViewController: UITableViewDataSource, UITableViewDelegate {
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myarray.count
    }
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath)
        cell.textLabel?.text = myarray[indexPath.item]
        return cell
    }
}
