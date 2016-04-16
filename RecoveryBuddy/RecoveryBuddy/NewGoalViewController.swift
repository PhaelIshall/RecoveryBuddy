//
//  NewGoalViewController.swift
//  RecoveryBuddy
//
//  Created by Wiem Ben Rim on 4/14/16.
//  Copyright © 2016 Wiem Ben Rim. All rights reserved.
//

import UIKit
import Parse

class NewGoalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.dataSource = self;
        pickerView.delegate = self;
        addDetails.delegate = self
        addDetails.text = "Placeholder text goes right here..."
        addDetails.textColor = UIColor.lightGrayColor()
        // Do any additional setup after loading the view.
    }
    
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     @IBOutlet weak var addDetails: UITextView!
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "continueToGoals"){
           // createGoal();
            segue.destinationViewController as! GoalsViewController
        }
        else{
            print("shut up");
        }
    }
    var pickerDataSource = ["Select goal type", "Meal plan", "Intuitive eating", "Exercise", "Not exercise", "Custom"];
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    func textViewDidBeginEditing(textView: UITextView) {
        
        if addDetails.textColor == UIColor.lightGrayColor() {
            addDetails.text = ""
            addDetails.textColor = UIColor.blackColor()
        }
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        if addDetails.text == "" {
            
            addDetails.text = "Placeholder text ..."
            addDetails.textColor = UIColor.lightGrayColor()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerDataSource[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        if(row == 0)
        {
            
        }
        else if(row == 1)
        {
            
        }
        else if(row == 2)
        {
            
        }
        else
        {
            
        }
    }

}